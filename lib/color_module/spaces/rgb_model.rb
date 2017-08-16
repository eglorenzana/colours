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
        values =  values.flatten.first(@components.size).compact
        values.each_with_index do |v, index|
          @components[index].value= v.round
        end			
      end      
      
    end
  end
end
