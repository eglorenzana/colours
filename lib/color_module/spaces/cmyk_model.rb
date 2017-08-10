# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  module Spaces
    class CMYKModel < ColorModel
      MIN = CMIN =  YMIN = MMIN = KMIN =  0
      MAX = CMAX =  YMAX = MMAX = KMAX =  1
      def initialize
        _params = {name: :CMYK , components: [:C, :M, :Y, :K], valid_ranges: []}
        4.times{ _params[:valid_ranges] << [MIN, MAX] }
        _params[:model_converter] = Converters::CMYKModelConverter
        super(_params)
      end
    end
  end
end
