# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module ColorModule
  module Converters
    class XYZModelConverter < ColorModelConverter
      def to_xyz
        @model
      end

      def to_rgb
        xyz_to_rgb(@model)
      end

      def to_cmyk
        rgb_to_cmyk(xyz_to_rgb(@model))
      end

      def to_lab
        xyz_to_lab(@model)
      end
    end
  end
end