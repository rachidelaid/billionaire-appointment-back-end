require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:application) { FactoryBot.create(:application) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post api_users_path,
              params: {
                name: "rachid",
                username: "rachidelaid",
                email: "rachid@test.com",
                password: "123456789",
                client_id: application.uid,
              }
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post api_users_path,
            params: { 
              name: "rachid",
              username: "rachidelaid",
              email: "rachid@test.com",
              password: "123456789",
              client_id: application.uid,
            }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User without client_id' do
        post api_users_path,
              params: {
                name: "rachid",
                username: "rachidelaid",
                email: "rachid@test.com",
                password: "123456789",
              }
        expect(response).to have_http_status(403)
        expect(response.body).to include("Invalid client ID")
        expect(User.count).to eq(0)
      end

      it 'does not create a new User with an invalid email' do
        post api_users_path,
              params: {
                name: "rachid",
                username: "rachidelaid",
                email: "bad_email",
                password: "123456789",
                client_id: application.uid,
              }
        expect(response).to have_http_status(422)
        expect(response.body).to include("Email is invalid")
        expect(User.count).to eq(0)
      end
    end
  end
end
