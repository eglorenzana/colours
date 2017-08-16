module ColorModule
  module Converters
    # Implements the conversion methods from LAB space for other spaces
    class LABModelConverter < ColorModelConverter
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
