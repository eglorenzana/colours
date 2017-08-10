# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module ColorModule
  module Converters
    class LabModelConverter < ColorModelConverter
      def to_lab
        @model
      end

      def to_xyz
        lab_to_xyz(@model)
      end

      def to_cmyk
        rgb_to_cmyk(to_rgb)
      end

      def to_rgb
        xyz_to_rgb(to_xyz)
      end
    end
  end
end