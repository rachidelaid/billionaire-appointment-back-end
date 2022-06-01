class BillionairesController < ApplicationController
  before_action :set_billionaire, only: %i[ show update destroy ]

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
    @billionaire = Billionaire.new(billionaire_params)

    if @billionaire.save
      render json: @billionaire, status: :created, location: @billionaire
    else
      render json: @billionaire.errors, status: :unprocessable_entity
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
    @billionaire.destroy
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
