class UtilitiesController < ApplicationController


  # GET /color_converters
  def index
    @spaces = ColorModule::Util.spaces_defined
    render json: @spaces
  end
  
  #POST /color_converters/:from_space/:to_space
  def convert_color
    begin
      @from_space  = params.fetch('from_space')
      @to_space  = params.fetch('to_space')
      @color_components =  params.fetch('components')
      @response= ColorModule::Util.perform_conversion(@from_space, @to_space, @color_components)
      @status = 200
    rescue KeyError => e
      @status = 400
      #pass info about the not found key
    rescue ColorModule::Spaces::ColorSpaceNotFound => e
      @status = 404
      @response = {message: e.to_s}
    end    
    render json: @response, status: @status
  end
  
  #POST /comparators/:comparator
  def compare_colors
    begin
      @comparator = params.fetch('comparator')
      @space  = compare_color_params.fetch('space')
      @color1 =  compare_color_params.fetch('color1').permit!.to_hash
      @color2 =  compare_color_params.fetch('color2').permit!.to_hash
      options =  compare_color_params.fetch('options', {}).permit!.to_hash
      @response= ColorModule::Util.perform_comparation(@comparator, @space, @color1, @color2, options)
      @status = 200
    rescue KeyError => e
      @status = 400
      #pass info about the not found KEY
    rescue ColorModule::Comparators::ColorComparatorError => e
      @status = 404
      @response = {error_message: e.to_s}
    end    
    render json: @response, status: @status
  end

  
  private
  def compare_color_params
    params.require(:color).permit!
  end
end
