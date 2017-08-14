module ColorModule
  module Spaces
    class ColorModelError < StandardError
      def initialize(params={})
        default_params = {msg: 'Size of components and valid_ranges must be same'}.merge(params)
        super(default_params.fetch(:msg, ''))
      end
    end
  end
end
