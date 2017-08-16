module ColorModule
  module Spaces
    # Model for create RGB colors
    class RGBModel < ColorModel
      MIN = RMIN =  GMIN = BMIN =  0
      MAX = RMAX =  GMAX = BMAX =  255

      def initialize
        params = { name: :RGB, components: %i[R G B], valid_ranges: [] }
        3.times { params[:valid_ranges] << [MIN, MAX] }
        params[:model_converter] = Converters::RGBModelConverter
        super(params)
      end

      def assign_components(*values)
        values = values.flatten.first(@components.size).compact
        values.each_with_index { |v, index| @components[index].value = v.round }
      end
    end
  end
end
