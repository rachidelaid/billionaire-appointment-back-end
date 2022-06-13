require 'rails_helper'

RSpec.describe '/oauth/token', type: :request do
  describe 'create token', type: :request do
    let(:application) { FactoryBot.create(:application) }
    let(:user) { FactoryBot.create(:user) }
    # let(:access_token) { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

    it 'succeeds' do
      post '/oauth/token', params: {
        grant_type: 'password',
        username: user.username,
        password: user.password,
        client_id: application.uid,
        client_secret: application.secret
      }
      expect(response).to be_successful
      expect(response.body).to include('token')
      expect(response.body).to include(user.to_json)
    end
  end
end
