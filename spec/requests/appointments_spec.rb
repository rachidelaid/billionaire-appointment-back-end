require 'rails_helper'

RSpec.describe '/appointments', type: :request do

  User.destroy_all
  Billionaire.destroy_all
  let(:user) { FactoryBot.create(:user) }
  let(:billionaire) { FactoryBot.create(:billionaire) }
  let(:application) { FactoryBot.create(:application) }
  let(:access_token) { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

  let(:valid_attributes) do
    { city: 'City', date: '2022-01-01', user_id: user.id, billionaire_id: billionaire.id }
  end

  let(:invalid_attributes) do
    { user_id: nil, billionaire_id: nil }
  end

  let(:valid_headers) do
    { Authorization: "Bearer #{access_token.token}"}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Appointment.create! valid_attributes
      get api_appointments_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Appointment' do
        expect do
          post api_appointments_path,
               params: { appointment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Appointment, :count).by(1)
      end

      it 'renders a JSON response with the new appointment' do
        post api_appointments_path,
             params: { appointment: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Appointment' do
        expect do
          post api_appointments_path,
               params: { appointment: invalid_attributes }, as: :json
        end.to change(Appointment, :count).by(0)
      end

      it 'renders a JSON response with errors for the new appointment' do
        post api_appointments_path,
             params: { appointment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested appointment' do
      appointment = Appointment.create! valid_attributes
      expect do
        delete api_appointment_path(appointment), headers: valid_headers, as: :json
      end.to change(Appointment, :count).by(-1)
    end
  end
end
