module ColorModule
  module Spaces
    # Model for create XYZ colors
    class XYZModel < ColorModel
      MIN = XMIN =  YMIN = ZMIN =  0
      MAX = XMAX =  YMAX = ZMAX =  1

      def initialize
        params = { name: :XYZ, components: %i[X Y Z], valid_ranges: [] }
        3.times { params[:valid_ranges] << [MIN, MAX] }
        params[:model_converter] = Converters::XYZModelConverter
        super(params)
      end
    end
  end
end
