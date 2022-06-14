class CustomTokensController < Doorkeeper::TokensController
  include AbstractController::Callbacks

  def create
    headers.merge!(authorize_response.headers)

    response = create_response(authorize_response.body)
    render json: response, status: authorize_response.status
  rescue Doorkeeper::Errors => e
    handle_token_exception(e)
  end

  private

  def create_response(response)
    return { error: 'invalid client id or secret' } if response[:error].to_s == 'invalid_client'

    return { error: 'wrong username or password' } if response[:error].to_s == 'invalid_grant'

    user = User.find_by(id: Doorkeeper::AccessToken.find_by(token: response['access_token']).resource_owner_id)
    { token: response, user: }
  end
end
