# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  module Spaces
    class LabModel < ColorModel
      MIN = LMIN = AMIN =  BMIN = -100
      MAX = LMAX = AMAX =  BMAX = 100
      def initialize
        _params = {name: :Lab , components: [:L, :a, :b], valid_ranges: []}
        3.times{ _params[:valid_ranges] << [MIN, MAX] }
        _params[:model_converter] = Converters::LabModelConverter
        super(_params)
      end
    end
  end
end
