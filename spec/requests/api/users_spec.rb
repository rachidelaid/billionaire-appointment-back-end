require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/api/users', type: :request do
  path '/api/users' do
    post 'Register a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          username: { type: :string },
          email: { type: :string },
          name: { type: :string },
          role: { type: :string },
          password: { type: :string }
        },
        required: %w[username email name password]
      }

      response '201', 'user created' do
        schema type: :object,
               properties: {
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :number },
                     name: { type: :string },
                     username: { type: :string },
                     email: { type: :string },
                     role: { type: :string },
                     access_token: { type: :string },
                     token_type: { type: :string },
                     expires_in: { type: :number },
                     refresh_token: { type: :string },
                     created_at: { format: 'date-time' }
                   }
                 }
               }
        let(:user) do
          { **build(:user).attributes,
            password: '123456',
            client_id: create(:application).uid }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'hello', client_id: create(:application).uid } }
        run_test!
      end

      response '403', 'forbidden request' do
        let(:user) { { name: 'hello' } }
        run_test!
      end
    end
  end

  path '/oauth/token' do
    post 'Login a user or refresh a token' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          client_secret: { type: :string },
          grant_type: { type: :string },
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password grant_type client_id client_secret]
      }

      response '200', 'user logged in' do
        schema type: :object,
               properties: {
                 token: {
                   type: :object,
                   properties: {
                     access_token: { type: :string },
                     token_type: { type: :string },
                     expires_in: { type: :number },
                     refresh_token: { type: :string },
                     created_at: { format: 'date-time' }
                   }
                 },
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :number },
                     name: { type: :string },
                     username: { type: :string },
                     email: { type: :string },
                     role: { type: :string },
                     created_at: { format: 'date-time' },
                     updated_at: { format: 'date-time' }
                   }
                 }
               }

        let(:application) { FactoryBot.create(:application) }
        let(:user) do
          { **build(:user).attributes,
            password: '123456',
            client_id: application.uid,
            client_secret: application.secret,
            grant_type: 'password' }
        end
        run_test!
      end

      response '400', 'bad request' do
        let(:application) { FactoryBot.create(:application) }
        let(:user) do
          { username: 'hello',
            password: nil,
            client_id: application.uid,
            client_secret: application.secret,
            grant_type: 'password' }
        end
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:user) do
          { **build(:user).attributes,
            password: '123456',
            grant_type: 'password' }
        end

        run_test!
      end
    end
  end

  path '/oauth/revoke' do
    post 'Logout a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          client_secret: { type: :string },
          token: { type: :string }
        },
        required: %w[token client_id client_secret]
      }

      response '200', 'user logged out' do
        schema type: :object
        let(:application) { FactoryBot.create(:application) }
        let(:current_user) { create(:user) }
        let(:access_token) { FactoryBot.create(:access_token, application:, resource_owner_id: current_user.id) }
        let(:user) do
          { **current_user.attributes,
            password: '123456',
            client_id: application.uid,
            client_secret: application.secret,
            token: access_token }
        end
        run_test!
      end
    end
  end
end
