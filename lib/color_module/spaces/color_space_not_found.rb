module ColorModule
  module Spaces
    class ColorSpaceNotFound < StandardError
      def initialize(space)
        super("The color space #{space} is not found. Try other space.")
      end
    end
  end
end
