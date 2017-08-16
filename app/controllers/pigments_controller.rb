# CRUD operations on Pigment resources
class PigmentsController < ApplicationController
  before_action :set_pigment, only: %i[show update destroy]

  # GET /pigments
  def index
    @pigments = Pigment.all

    render json: @pigments
  end

  # GET /pigments/1
  def show
    render json: @pigment
  end

  # POST /pigments
  def create
    @pigment = Pigment.new(pigment_params)

    if @pigment.save
      render json: @pigment, status: :created, location: @pigment
    else
      render json: { errors: @pigment.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pigments/1
  def update
    if @pigment.update(pigment_params)
      render json: @pigment
    else
      render json: { errors: @pigment.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /pigments/1
  def destroy
    @pigment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pigment
    @pigment = Pigment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def pigment_params
    params.fetch(:pigment, {}).permit(:name)
  end
end
