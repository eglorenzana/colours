# Operations for convert color spaces and compare colors
# It provides functionality to convert from and to following spaces
# * RGB
# * CMYK
# * LAB
# * XYZ
# Default Comparator is based on CIE dEcmc standard
class UtilitiesController < ApplicationController
  COLOR_SERIALIZER = ColorModule::Serializers::ColorSerializer
  COMPARATION_SERIALIZER = ColorModule::Serializers::ComparatorResultSerializer
  Util = ColorModule::Util
  before_action :set_serializer_options, only: %i[convert_color compare_colors]
  before_action :converter_params, only: %i[convert_color]
  before_action :comparator_params, only: %i[compare_colors]
  # GET /color_converters
  def index
    @spaces = ColorModule::Util.spaces_defined
    render json: @spaces
  end

  # POST /color_converters/:from_space/:to_space
  def convert_color
    begin
      perform_conversion
      @options_for_serializer.merge!(serializer: COLOR_SERIALIZER)
    rescue KeyError, ColorModule::ColorComponentError => e
      manage_error(:bad_request, e)
    rescue ColorModule::Spaces::ColorSpaceNotFound => e
      manage_error(:not_found, e)
    end
    render({ json: @response, status: @status }.merge(@options_for_serializer))
  end

  # POST /comparators/:comparator
  def compare_colors
    begin
      perform_comparation
      @options_for_serializer.merge!(serializer: COMPARATION_SERIALIZER)
    rescue KeyError, ColorModule::ColorComponentError => e
      manage_error(:bad_request, e)
    rescue  ColorModule::Spaces::ColorSpaceNotFound,
            ColorModule::Comparators::ColorComparatorError => e
      manage_error(:not_found, e)
    end
    render({ json: @response, status: @status }.merge(@options_for_serializer))
  end

  private

  def perform_conversion
    from_space = @converter_params.fetch(:from_space)
    to_space = @converter_params.fetch(:to_space)
    color_components = @converter_params.fetch(:components)
    @response = Util.perform_conversion(from_space, to_space, color_components)
    @status = :ok
  end

  def perform_comparation
    comparator = @comparator_params.fetch(:comparator)
    color1 = @comparator_params.fetch(:color1)
    space = @comparator_params.fetch(:space)
    color2 = @comparator_params.fetch(:color2)
    options = @comparator_params.fetch(:options, {})
    @response = Util.perform_comparation(comparator,
                                         space, color1, color2, options)
    @status = :ok
  end

  def manage_error(response_code, rescued_exception)
    @status = response_code
    @response = { error_message: rescued_exception.to_s }
  end

  def set_serializer_options
    @options_for_serializer = {}
  end

  def converter_params
    parameter_list = %w[from_space to_space components]
    @converter_params =
      params.permit!.to_h
            .keep_if { |key, _value| parameter_list.include?(key) }
  end

  def comparator_params
    parameter_list = %w[comparator space color1 color2 options]
    @comparator_params =
      params.permit!.to_h
            .keep_if { |key, _value| parameter_list.include?(key) }
  end
end
