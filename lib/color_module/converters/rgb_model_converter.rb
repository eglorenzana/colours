module ColorModule
  module Converters
    class RGBModelConverter < ColorModelConverter
      def to_rgb
        @model
      end

      def to_xyz
        rgb_to_xyz(@model)
      end

      def to_cmyk
        rgb_to_cmyk(@model)
      end

      def to_lab
        xyz_to_lab(to_xyz)
      end
    end
  end
end