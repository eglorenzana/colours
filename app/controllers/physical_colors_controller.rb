class PhysicalColorsController < ApplicationController
  before_action :set_physical_color, only: [:show, :update, :destroy]

  # GET /physical_colors
  def index
    @physical_colors = PhysicalColor.all

    render json: @physical_colors
  end

  # GET /physical_colors/1
  def show
    render json: @physical_color
  end

  # POST /physical_colors
  def create
    @physical_color = PhysicalColor.new(physical_color_params)

    if @physical_color.save
      render json: @physical_color, status: :created, location: @physical_color
    else
      render json: @physical_color.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /physical_colors/1
  def update
    if @physical_color.update(physical_color_params)
      render json: @physical_color
    else
      render json: @physical_color.errors, status: :unprocessable_entity
    end
  end

  # DELETE /physical_colors/1
  def destroy
    @physical_color.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_physical_color
      @physical_color = PhysicalColor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def physical_color_params
      params.fetch(:physical_color, {})
    end
end
