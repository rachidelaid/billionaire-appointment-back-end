require 'rails_helper'

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
              created_at: { format: "date-time" },
              updated_at: { format: "date-time" },
            }
          }
        run_test!
      end

      response '401', 'unauthorized request' do
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
          user_id: { type: :number },
        },
        required: [ 'city', 'date', 'billionaire_id', 'user_id' ]
      }

      response '201', 'appointment created' do
        let(:appointment) {{
          city: 'New York',
          date: '2020-01-01',
          billionaire_id: 1,
          user_id: 1
        }}

        run_test!
      end

      response '422', 'invalid request' do
        let(:appointment) {{
          city: 'New York'
        }}
        run_test!
      end

      response '401', 'unauthorized request' do
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
        run_test!
      end

      response '401', 'unauthorized request' do
        run_test!
      end
    end
  end

end
