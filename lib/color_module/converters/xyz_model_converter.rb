module ColorModule
  module Converters
    # Implements the conversion methods from XYZ space for other spaces
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
