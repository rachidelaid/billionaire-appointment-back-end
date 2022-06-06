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

  

  let(:valid_billionaire) { build :billionaire }
  let(:valid_attributes) { valid_billionaire.attributes }
  let(:invalid_billionaire) { build :billionaire, name: nil }
  let(:invalid_attributes) { invalid_billionaire.attributes }

  let(:application) { FactoryBot.create(:application) }
  let(:current_user) { FactoryBot.create(:user, role: 'admin') }
  let(:access_token) { FactoryBot.create(:access_token, application: application, resource_owner_id: current_user.id) }

  let(:valid_headers) do
    {"Authorization": "Bearer #{access_token.token}"}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      valid_billionaire.save
      get api_billionaires_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      valid_billionaire.save
      get api_billionaire_url(valid_billionaire), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Billionaire' do
      post api_billionaires_url,
            params: { billionaire: valid_attributes },
            headers: valid_headers,
            as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end
end
