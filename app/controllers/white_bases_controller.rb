# CRUD operations on WhiteBase resources
class WhiteBasesController < ApplicationController
  before_action :set_white_base, only: %i[show update destroy]

  # GET /white_bases
  def index
    @white_bases = WhiteBase.all

    render json: @white_bases
  end

  # GET /white_bases/1
  def show
    render json: @white_base
  end

  # POST /white_bases
  def create
    @white_base = WhiteBase.new(white_base_params)

    if @white_base.save
      render json: @white_base, status: :created, location: @white_base
    else
      render json: { errors: @white_base.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /white_bases/1
  def update
    if @white_base.update(white_base_params)
      render json: @white_base
    else
      render json: { errors: @white_base.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /white_bases/1
  def destroy
    @white_base.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_white_base
    @white_base = WhiteBase.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def white_base_params
    params.fetch(:white_base, {}).permit(:name)
  end
end
