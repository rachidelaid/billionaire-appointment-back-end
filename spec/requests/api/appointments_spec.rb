require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/api/appointments', type: :request do
  path '/api/appointments' do
    get 'Retrieves all appointments' do
      tags 'Appointments'
      produces 'application/json'
      security [{ bearerAuth: [] }]
      response '200', 'list of appointments' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   city: { type: :string },
                   date: { format: :date },
                   user_id: { type: :number },
                   billionaire_id: { type: :number },
                   created_at: { format: 'date-time' },
                   updated_at: { format: 'date-time' }
                 }
               }
        authorization
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:appointment) {{city: 'New York'}}
        let(:Authorization) { 'invalid' }
        run_test!
      end
    end

    post 'Creates an appointment' do
      tags 'Appointments'
      consumes 'application/json'
      security [{ bearerAuth: [] }]
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          city: { type: :string },
          date: { format: :date },
          billionaire_id: { type: :number },
          user_id: { type: :number }
        },
        required: %w[city date billionaire_id user_id]
      }

      response '201', 'appointment created' do
        let(:billionaire) { FactoryBot.create(:billionaire) }
        let(:appointment) do
          {
            city: 'New York',
            date: '2020-01-01',
            billionaire_id: billionaire.id,
            user_id: 1
          }
        end
        authorization
        run_test!
      end

      response '422', 'invalid request' do
        let(:appointment) do
          {
            city: nil
          }
        end
        authorization
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:appointment) do
          {
            city: nil
          }
        end
        let(:Authorization) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/appointments/{id}' do
    delete 'Deletes an appointment' do
      tags 'Appointments'
      consumes 'application/json'
      security [{ bearerAuth: [] }]
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'appointment deleted' do
        schema type: :string
        let(:billionaire) { FactoryBot.create(:billionaire) }
        let(:application) { FactoryBot.create(:application) }
        let(:current_user) { FactoryBot.create(:user, role: 'admin') }
        let(:access_token) { FactoryBot.create(:access_token, application:, resource_owner_id: current_user.id) }
        let(:Authorization) { "Bearer #{access_token.token}" }
        let(:id) do
          Appointment.create(
            city: 'New York',
            date: '2022-02-02',
            user_id: current_user.id,
            billionaire_id: billionaire.id
          ).id
        end
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:billionaire) { FactoryBot.create(:billionaire) }
        let(:application) { FactoryBot.create(:application) }
        let(:current_user) { FactoryBot.create(:user, role: 'admin') }
        let(:access_token) { FactoryBot.create(:access_token, application:, resource_owner_id: current_user.id) }
        let(:Authorization) { "Bearer #{access_token.token}" }
        let(:id) do
          Appointment.create(
            city: 'New York',
            date: '2022-02-02',
            user_id: current_user.id,
            billionaire_id: billionaire.id
          ).id
        end
        let(:Authorization) { 'invalid' }
        run_test!
      end
    end
  end
end
