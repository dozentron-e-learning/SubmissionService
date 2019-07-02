class Submission
  include Mongoid::Document
  include Mongoid::Paperclip

  STRONG_PARAMETERS = %i[
    file
  ].freeze

  has_mongoid_attached_file :file

  do_not_validate_attachment_file_type :file

  field :exercise_validated, type: Boolean, default: false

  validates :file, presence: true
end
