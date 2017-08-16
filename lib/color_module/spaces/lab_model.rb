module ColorModule
  module Spaces
    # Model for create LAB colors
    class LABModel < ColorModel
      MIN = LMIN = AMIN =  BMIN = -150
      MAX = LMAX = AMAX =  BMAX = 150
      def initialize
        params = { name: :LAB, components: %i[L a b], valid_ranges: [] }
        3.times { params[:valid_ranges] << [MIN, MAX] }
        params[:model_converter] = Converters::LABModelConverter
        super(params)
      end
    end
  end
end
