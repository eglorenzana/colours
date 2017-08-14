module ColorModule
  module Comparators
    class ColorComparatorError < StandardError
      def initialize(params={})
        default_params = {msg: 'The Comparator is not found: '}.merge(params)
        data_msg = params.fetch(:name, '')
        super(default_params.fetch(:msg, '') + data_msg)
      end
    end
  end
end
