require 'rails_helper'
# let(:test_user) { create :user }
# let(:test_category) { create :category }
# before { sign_in test_user }
# let(:valid_purchase) { build :purchase, author: test_user, category: test_category }
# let(:invalid_purchase) { build :purchase, name: nil, author: test_user, category: test_category }
# let(:valid_attributes) { valid_purchase.attributes }

# let(:invalid_attributes) { invalid_purchase.attributes }


RSpec.describe '/billionaires', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Billionaire. As you add validations to Billionaire, be sure to
  # adjust the attributes here as well.
  let(:valid_billionaire) {build :billionaire}
  let(:valid_attributes) {valid_billionaire.attributes}
  let(:invalid_billionaire) {build :billionaire, name: nil}
  let(:invalid_attributes) {invalid_billionaire.attributes}
  

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # BillionairesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  

  describe 'GET /index' do
    it 'renders a successful response' do
      valid_billionaire.save
      get api_billionaires_url, as: :json
      expect(response).to be_successful
    end
  end

  # describe 'GET /show' do
  #   it 'renders a successful response' do
  #     billionaire = Billionaire.create! valid_attributes
  #     get billionaire_url(billionaire), as: :json
  #     expect(response).to be_successful
  #   end
  # end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Billionaire' do
  #       expect do
  #         post billionaires_url,
  #              params: { billionaire: valid_attributes }, headers: valid_headers, as: :json
  #       end.to change(Billionaire, :count).by(1)
  #     end

  #     it 'renders a JSON response with the new billionaire' do
  #       post billionaires_url,
  #            params: { billionaire: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Billionaire' do
  #       expect do
  #         post billionaires_url,
  #              params: { billionaire: invalid_attributes }, as: :json
  #       end.to change(Billionaire, :count).by(0)
  #     end

  #     it 'renders a JSON response with errors for the new billionaire' do
  #       post billionaires_url,
  #            params: { billionaire: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested billionaire' do
  #       billionaire = Billionaire.create! valid_attributes
  #       patch billionaire_url(billionaire),
  #             params: { billionaire: new_attributes }, headers: valid_headers, as: :json
  #       billionaire.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the billionaire' do
  #       billionaire = Billionaire.create! valid_attributes
  #       patch billionaire_url(billionaire),
  #             params: { billionaire: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the billionaire' do
  #       billionaire = Billionaire.create! valid_attributes
  #       patch billionaire_url(billionaire),
  #             params: { billionaire: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including('application/json'))
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested billionaire' do
  #     billionaire = Billionaire.create! valid_attributes
  #     expect do
  #       delete billionaire_url(billionaire), headers: valid_headers, as: :json
  #     end.to change(Billionaire, :count).by(-1)
  #   end
  # end
end
