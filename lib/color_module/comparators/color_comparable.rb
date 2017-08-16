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
        attr_reader :result
        def initialize(result)
          @result = result
        end
        
        def value
          @result.value
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