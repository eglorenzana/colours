module ColorModule
  module Spaces
    # Error class for Color space when is no  found
    class ColorSpaceNotFound < StandardError
      def initialize(space)
        super("The color space #{space} is not found. Try other space.")
      end
    end
  end
end
