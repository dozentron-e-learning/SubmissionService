class Api::V1::Submission
  include Mongoid::Document
  include ServiceTokenConcern

  VALIDATION_NOT_PERFORMED = :not_performed
  VALIDATION_SUCCEEDED = :success
  VALIDATION_FAILED = :failed

  # has_one :exercise, class_name: 'Api::V1::Exercise', :foreign_key => "exercise_id"

  attr_accessor :auth_token

  after_create do |obj|
    obj.update_attribute(:token, service_token("#{obj.plugin}_Submission_Validation", "SubmissionService", {
        submission_id: obj.id.to_s,
        exercise_id: obj.exercise_id.to_s,
        scope: [
            :validation, :results
        ]
    }))
    SubmissionPublisher.new.create obj
  end
  after_update(if: :validation_success?) { |obj| SubmissionPublisher.new.update obj }


  before_validation(if: :new_record?) { |obj| obj.plugin = Api::V1::Exercise.find(obj.exercise_id).plugin }

  STRONG_PARAMETERS = %i[
    exercise_id
    file
    validation_status
    file_validation_error
    general_validation_error
    general_validation_error_details
  ].freeze

  mount_uploader :file, SubmissionUploader

  field :plugin, type: String
  field :token, type: String
  field :validation_status, type: Symbol, default: VALIDATION_NOT_PERFORMED
  field :exercise_id, type: BSON::ObjectId
  field :file_validation_error, type: String
  field :general_validation_error, type: String
  field :general_validation_error_details, type: String

  validates :file, presence: true
  validates :plugin, presence: true
  validates :token, presence: true, unless: :new_record?

  def validation_success?
    self.validation_status == VALIDATION_SUCCEEDED || self.validation_status == VALIDATION_SUCCEEDED.to_s
  end
end
