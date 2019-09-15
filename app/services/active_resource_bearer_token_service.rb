module ActiveResourceBearerTokenService
  def self.token=(token)
    # ApplicationResource.connection.bearer_token = token
    # Add your Active Resource Classes here
    Api::V1::Exercise.connection.bearer_token = token
  end
end
