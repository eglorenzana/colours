module ColorModule
  module Comparators
    DECIMAL_DIGITS = 2
    # Interface for color comparators
    module ColorComparable
      DEFAULT_COMPARATOR = Comparators::CMCComparator
      def compare_with(second_color, params = {})
        comparator = params[:comparator] || DEFAULT_COMPARATOR
        ComparatorResult.new(comparator.compare(self, second_color, params))
      end

      # The result for an operation of compare two colors
      class ComparatorResult
        alias read_attribute_for_serialization send
        attr_reader :result, :value

        def initialize(result)
          @result = result
          @value =  @result.value
        end

        def color1
          @result.color1
        end

        def color2
          @result.color2
        end
      end
    end
  end
end
