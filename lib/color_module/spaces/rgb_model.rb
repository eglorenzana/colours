# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  module Spaces  
    class RGBModel < ColorModel
      MIN = RMIN =  GMIN = BMIN =  0
      MAX = RMAX =  GMAX = BMAX =  255
      def initialize
        _params = {name: :RGB , components: [:R, :G, :B], valid_ranges: []}
        3.times{ _params[:valid_ranges] << [MIN, MAX] }
        _params[:model_converter] = Converters::RGBModelConverter
        super(_params)
      end
      def assign_components(*values)
        _values =  values.flatten
        @components.each_with_index do |cc, index|
          cc.value= _values[index].round
        end			
      end		
    end
  end
end
