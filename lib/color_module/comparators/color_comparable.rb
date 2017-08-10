# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
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