class CustomTokensController < Doorkeeper::TokensController
  include AbstractController::Callbacks

  def create
    headers.merge!(authorize_response.headers)
    body = authorize_response.body
    user = User.find_by(id: Doorkeeper::AccessToken.find_by(token: body['access_token']).resource_owner_id)

    render json: { token: body, user: },
           status: authorize_response.status
  rescue Errors::DoorkeeperError => e
    handle_token_exception(e)
  end
end
