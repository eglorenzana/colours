# CRUD operations on Tint resources
class TintsController < ApplicationController
  before_action :set_tint, only: %i[show update destroy]

  # GET /tints
  def index
    @tints = Tint.all

    render json: @tints
  end

  # GET /tints/1
  def show
    render json: @tint
  end

  # POST /tints
  def create
    @tint = Tint.new(tint_params)

    if @tint.save
      render json: @tint, status: :created, location: @tint
    else
      render json: { errors: @tint.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tints/1
  def update
    if @tint.update(tint_params)
      render json: @tint
    else
      render json: { errors: @tint.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /tints/1
  def destroy
    @tint.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tint
    @tint = Tint.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tint_params
    params.fetch(:tint, {}).permit(:name)
  end
end
