class SubmissionPublisher < ActiveBunny::Publisher
  def create(submission)
    Rails.logger.info "Send Message about new Submission: #{submission.id.to_s}"
    #TODO Generate token to use in controller
    publish({
        id: submission.id.to_s,
        exercise_id: submission.exercise_id.to_s,
        validation_token: submission.token,
        plugin: submission.plugin
    }.to_json)
  end

  def update(submission)
    Rails.logger.info "Send Message about updated Submission: #{submission.id.to_s}"
    #TODO Generate token to use in controller
    publish({
        id: submission.id.to_s,
        exercise_id: submission.exercise_id.to_s,
        validation_token: submission.token,
        plugin: submission.plugin
    }.to_json)
  end
end