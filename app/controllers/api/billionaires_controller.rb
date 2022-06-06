class Api::BillionairesController < ApplicationController
  before_action :doorkeeper_authorize!, except: %i[index show]
  before_action :set_billionaire, only: %i[show update destroy]

  # GET /billionaires
  def index
    @billionaires = Billionaire.all

    render json: @billionaires
  end

  # GET /billionaires/1
  def show
    render json: @billionaire
  end

  # POST /billionaires
  def create
    if current_user.role == 'admin'
      @billionaire = Billionaire.new(billionaire_params)

      if @billionaire.save
        render json: @billionaire, status: :created
      else
        render json: @billionaire.errors, status: :unprocessable_entity
      end
    else
      render json: "\"You're not allowed to create billionaires\"", status: :unauthorized
    end
  end

  # PATCH/PUT /billionaires/1
  def update
    if @billionaire.update(billionaire_params)
      render json: @billionaire
    else
      render json: @billionaire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /billionaires/1
  def destroy
    if current_user.role == 'admin'
      @billionaire.destroy
      render json: "\"Billionaire deleted successfully\"", status: :ok
    else
      ender json: "\"You're not allowed to delete billionaires\"", status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_billionaire
    @billionaire = Billionaire.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def billionaire_params
    params.require(:billionaire).permit(:name, :title, :image, :price, :description)
  end
end
