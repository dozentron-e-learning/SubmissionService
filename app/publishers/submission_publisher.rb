class SubmissionPublisher < ActiveBunny::Publisher
  def create(submission)
    Rails.logger.info "Send Message about new Submission: #{submission.id.to_s}"
    #TODO Generate token to use in controller
    publish({id: submission.id.to_s, validation_token: ""}.to_json)
  end

  def update(submission)
    Rails.logger.info "Send Message about updated Submission: #{submission.id.to_s}"
    #TODO Generate token to use in controller
    publish({id: submission.id.to_s, validation_token: ""}.to_json)
  end
end