module ColorModule
  module Spaces
    class XYZModel < ColorModel
      MIN = XMIN =  YMIN = ZMIN =  0
      MAX = XMAX =  YMAX = ZMAX =  1
      def initialize
        _params = {name: :XYZ , components: [:X, :Y, :Z], valid_ranges: []}
        3.times{ _params[:valid_ranges] << [MIN, MAX] }
        _params[:model_converter] = Converters::XYZModelConverter
        super(_params)
      end
    end
  end
end
