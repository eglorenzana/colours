module ColorModule
  module Spaces
    class LABModel < ColorModel
      MIN = LMIN = AMIN =  BMIN = -150
      MAX = LMAX = AMAX =  BMAX = 150
      def initialize
        _params = {name: :LAB , components: [:L, :a, :b], valid_ranges: []}
        3.times{ _params[:valid_ranges] << [MIN, MAX] }
        _params[:model_converter] = Converters::LABModelConverter
        super(_params)
      end
    end
  end
end
