class UtilitiesController < ApplicationController


  # GET /color_converters
  def index
    @spaces = ColorModule::Util.spaces_defined
    render json: @spaces
  end
  
  #POST /color_converters/:from_space/:to_space
  def convert_color
    options_for_serializer = {}
    begin
      @from_space  = params.fetch('from_space')
      @to_space  = params.fetch('to_space')
      @color_components =  params.fetch('components')
      @response= ColorModule::Util.perform_conversion(@from_space, @to_space, @color_components)
      @status = :ok
      options_for_serializer.merge!(serializer: ColorModule::Serializers::ColorSerializer)
    rescue KeyError, ColorModule::ColorComponentError => e
      @status = :bad_request
      @response = {message: e.to_s}
    rescue ColorModule::Spaces::ColorSpaceNotFound => e
      @status = :not_found
      @response = {message: e.to_s}
    end    
    render({json: @response, status: @status}.merge(options_for_serializer))
  end
  
  #POST /comparators/:comparator
  def compare_colors
    options_for_serializer = {}
    begin
      @comparator = params.fetch('comparator')
      @space  = params.fetch('space')
      @color1 =  params.fetch('color1')
      @color2 =  params.fetch('color2')
      options =  params.fetch('options', {}).permit!.to_hash
      @response= ColorModule::Util.perform_comparation(@comparator, @space, @color1, @color2, options)
      @status = :ok
      options_for_serializer.merge!(serializer: ColorModule::Serializers::ComparatorResultSerializer)
    rescue KeyError, ColorModule::ColorComponentError => e
      @status = :bad_request
      @response = {error_message: e.to_s}
    rescue ColorModule::Spaces::ColorSpaceNotFound, 
        ColorModule::Comparators::ColorComparatorError => e
      @status = :not_found
      @response = {error_message: e.to_s}
    end    
    render({json: @response, status: @status}.merge(options_for_serializer))
  end

  
  private

end
