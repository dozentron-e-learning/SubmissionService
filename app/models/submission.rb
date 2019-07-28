class Submission
  include Mongoid::Document

  VALIDATION_NOT_PERFORMED = :not_performed
  VALIDATION_SUCCEEDED = :succeeded
  VALIDATION_FAILED = :failed

  after_create { |obj| SubmissionPublisher.new.create obj }
  after_update(if: :validation_success?) { |obj| SubmissionPublisher.new.update obj }

  STRONG_PARAMETERS = %i[
    exercise_id
    file
    validation_status
  ].freeze

  mount_uploader :file, SubmissionUploader

  field :validation_status, type: Boolean, default: VALIDATION_NOT_PERFORMED
  field :exercise_id, type: BSON::ObjectId

  validates :file, presence: true

  def validation_success?
    self.validation_status == VALIDATION_SUCCEEDED
  end
end
