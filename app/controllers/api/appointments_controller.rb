class Api::AppointmentsController < ApplicationController
  before_action :doorkeeper_authorize!

  # GET /appointments
  def index
    @appointments = Appointment.where(user_id: current_user.id).order(:date)

    render json: @appointments
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment = Appointment.find(params[:id])

    render json: 'Appointment deleted successfully', status: :ok if @appointment.destroy
  rescue ActiveRecord::RecordNotFound => e
    render json: e, status: :bad_request
  end

  private

  # Only allow a list of trusted parameters through.
  def appointment_params
    parameters = params.require(:appointment).permit(:city, :date, :billionaire_id)
    parameters[:user_id] = current_user.id
    parameters
  end
end
