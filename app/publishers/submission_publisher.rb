class SubmissionPublisher < ActiveBunny::Publisher
  def create(submission)
    #TODO Generate token to use in controller
    publish({id: submission.id.to_s, validation_token: ""}.to_json)
  end

  def update(submission)
    #TODO Generate token to use in controller
    publish({id: submission.id.to_s, validation_token: ""}.to_json)
  end
end