class Submission
  include Mongoid::Document
  include Mongoid::Paperclip

  STRONG_PARAMETERS = %i[
    title
    description
    deadline
    visible_date
    do_plagiarism_check
    exercise_test
    exercise_hidden_test
    exercise_stub
  ].freeze

  has_mongoid_attached_file :file

  do_not_validate_attachment_file_type :file

  field :exercise_validated, type: Boolean, default: false

  validates :file, presence: true
end
