module ColorModule
  module Converters
    # Implements the conversion methods from CMYK space for other spaces
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
