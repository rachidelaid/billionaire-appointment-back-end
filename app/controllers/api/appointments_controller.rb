class Api::AppointmentsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
  def index
    @appointments = Appointment.all

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
    @appointment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:city, :date, :user_id, :billionaire_id)
  end
end
