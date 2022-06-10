require 'rails_helper'

RSpec.describe '/api/users', type: :request do
  path '/api/users' do
    post 'Register a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
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

        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end

      response '403', 'forbidden request' do
        run_test!
      end
    end
  end

  path '/oauth/token' do
    post 'Login a user or refresh a token' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
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

      response '201', 'user logedin' do
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

        run_test!
      end

      response '400', 'bad request' do
        run_test!
      end

      response '401', 'unauthorized request' do
        run_test!
      end
    end
  end

  path '/oauth/revoke' do
    post 'Logout a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          client_id: { type: :string },
          client_secret: { type: :string },
          token: { type: :string }
        },
        required: %w[token client_id client_secret]
      }

      response '201', 'user logedout' do
        schema type: :object
        run_test!
      end
    end
  end
end
