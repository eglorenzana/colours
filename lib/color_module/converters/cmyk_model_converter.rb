# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module ColorModule
  module Converters
    class CMYKModelConverter < ColorModelConverter
      def to_cmyk
        @model
      end

      def to_xyz
        rgb_to_xyz(cmyk_to_rgb(@model))
      end

      def to_rgb
        cmyk_to_rgb(@model)
      end

      def to_lab
        xyz_to_lab(to_xyz)
      end
    end
  end
end