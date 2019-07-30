class Submission
  include Mongoid::Document

  VALIDATION_NOT_PERFORMED = :not_performed
  VALIDATION_SUCCEEDED = :success
  VALIDATION_FAILED = :failed

  after_create { |obj| SubmissionPublisher.new.create obj }
  after_update(if: :validation_success?) { |obj| SubmissionPublisher.new.update obj }

  STRONG_PARAMETERS = %i[
    exercise_id
    file
    validation_status
    file_validation_error
    general_validation_error
    general_validation_error_details
  ].freeze

  mount_uploader :file, SubmissionUploader

  field :validation_status, type: Symbol, default: VALIDATION_NOT_PERFORMED
  field :exercise_id, type: BSON::ObjectId
  field :file_validation_error, type: String
  field :general_validation_error, type: String
  field :general_validation_error_details, type: String

  validates :file, presence: true

  def validation_success?
    self.validation_status == VALIDATION_SUCCEEDED || self.validation_status == VALIDATION_SUCCEEDED.to_s
  end
end
