module ColorModule
  module Spaces
    # Model for create CMYK colors
    class CMYKModel < ColorModel
      MIN = CMIN =  YMIN = MMIN = KMIN =  0
      MAX = CMAX =  YMAX = MMAX = KMAX =  1
      def initialize
        params = { name: :CMYK, components: %i[C M Y K], valid_ranges: [] }
        4.times { params[:valid_ranges] << [MIN, MAX] }
        params[:model_converter] = Converters::CMYKModelConverter
        super(params)
      end
    end
  end
end
