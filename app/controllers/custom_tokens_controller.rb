class CustomTokensController < Doorkeeper::TokensController
  include AbstractController::Callbacks

  def create
    headers.merge!(authorize_response.headers)
    
    response = createResponse(authorize_response.body)
    render json: response, status: authorize_response.status
  rescue Doorkeeper::Errors => e
    handle_token_exception(e)
  end

  private
  def createResponse(response)
    if response[:error].to_s == "invalid_client"
      return { error: "invalid client id or secret" }
    end

    if response[:error].to_s == "invalid_grant"
      return { error: "wrong username or password" }
    end

    user = User.find_by(id: Doorkeeper::AccessToken.find_by(token: response['access_token']).resource_owner_id)
    return { token: response, user: }
  end
end
