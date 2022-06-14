require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/api/billionaires', type: :request do
  path '/api/billionaires' do
    get 'Retrieves all billionaires' do
      tags 'Billionaires'
      produces 'application/json'

      response '200', 'list of billionaires' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   title: { type: :string },
                   image: { type: :string },
                   price: { type: :number, format: :float },
                   description: { type: :string },
                   created_at: { format: 'date-time' },
                   updated_at: { format: 'date-time' }
                 }
               }
        run_test!
      end
    end

    post 'Creates a billionaire' do
      tags 'Billionaires'
      consumes 'application/json'
      security [{ bearerAuth: [] }]
      parameter name: :billionaire, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          title: { type: :string },
          image: { type: :string },
          price: { type: :number, format: :float },
          description: { type: :string }
        },
        required: %w[name title image price description]
      }

      response '201', 'billionaire created' do
        let(:billionaire) do
          {
            name: 'Bill Gates',
            title: 'Co-founder of Microsoft',
            price: 3120,
            image: 'https://github.com/orozCoding/billionares-pictures/blob/main/round_pictures/pc_bill.png?raw=true',
            description: 'Billgates is an American business magnate, software developer'
          }
        end
        authorization
        run_test!
      end

      response '422', 'invalid request' do
        let(:billionaire) { { name: 'invalid' } }
        authorization
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:billionaire) { 'invalid' }
        let(:Authorization) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/billionaires/{id}' do
    get 'Retrieves a billionaire' do
      tags 'Billionaires'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'a billionaire' do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 title: { type: :string },
                 image: { type: :string },
                 price: { type: :number, format: :float },
                 description: { type: :string },
                 created_at: { format: 'date-time' },
                 updated_at: { format: 'date-time' }
               }
        let(:id) do
          Billionaire.create(
            name: 'Bonjour',
            title: 'Bom dia',
            price: 1,
            image: 'Good Afternoon',
            description: 'Guten Tag'
          ).id
        end
        run_test!
      end
    end

    delete 'Deletes a billionaire' do
      tags 'Billionaires'
      consumes 'application/json'
      security [{ bearerAuth: [] }]
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'billionaire deleted' do
        schema type: :string
        let(:id) do
          Billionaire.create(
            name: 'Bonjour',
            title: 'Bom dia',
            price: 1,
            image: 'Good Afternoon',
            description: 'Guten Tag'
          ).id
        end
        authorization
        run_test!
      end

      response '401', 'unauthorized request' do
        let(:id) { 'invalid' }
        let(:Authorization) { 'invalid' }
        run_test!
      end
    end
  end
end
