require 'rails_helper'

RSpec.describe '/appointments', type: :request do
  before :example do
    User.destroy_all
    Billionaire.destroy_all
    @user = FactoryBot.create(:user)
    @billionaire = FactoryBot.create(:billionaire)
  end

  let(:valid_attributes) do
    { city: 'City', date: '2022-01-01', user_id: @user.id, billionaire_id: @billionaire.id }
  end

  let(:invalid_attributes) do
    { user_id: nil, billionaire_id: nil }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Appointment.create! valid_attributes
      get api_appointments_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      appointment = Appointment.create! valid_attributes
      get api_appointment_path(appointment), as: :json
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

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { city: 'London' }
      end

      it 'updates the requested appointment' do
        appointment = Appointment.create! valid_attributes
        patch api_appointment_path(appointment),
              params: { appointment: new_attributes }, headers: valid_headers, as: :json
        appointment.reload
        expect(appointment.city).to eq('London')
      end

      it 'renders a JSON response with the appointment' do
        appointment = Appointment.create! valid_attributes
        patch api_appointment_path(appointment),
              params: { appointment: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the appointment' do
        appointment = Appointment.create! valid_attributes
        patch api_appointment_path(appointment),
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
