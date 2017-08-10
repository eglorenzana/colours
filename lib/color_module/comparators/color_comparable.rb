module ColorModule
  module Comparators
    module ColorComparable
      DEFAULT_COMPARATOR =  Comparators::CMCComparator 
      def compare_with(second_color, params={})
        _comparator = params[:comparator] || DEFAULT_COMPARATOR
        _comparator.compare(self, second_color, params)
      end
    end
  end
end