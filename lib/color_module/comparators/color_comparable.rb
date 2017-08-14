module ColorModule
  module Comparators
    DECIMAL_DIGITS = 2
    module ColorComparable
      DEFAULT_COMPARATOR =  Comparators::CMCComparator 
      def compare_with(second_color, params={})
        _comparator = params[:comparator] || DEFAULT_COMPARATOR
        ComparatorResult.new(_comparator.compare(self, second_color, params))
      end
      class ComparatorResult
        alias :read_attribute_for_serialization :send
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
        
        def method_missing(method, *args)
          if @result.respond_to?(method)
            @result.send(method)
          end
        end
      end
    end
  end
end