# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module ColorModule
  module Mixers
    # Mix colors
    class PhysicalColorMixer
      def initialize(first_color, second_color)
        @first_color = first_color
        @second_color = second_color
      end

      def self.mix(first_color, _second_color, params = {})
        _p1 = params[:p1]
        _p2 = params[:p2]
        first_color
      end

      def mix(p1, p2)
        self.class.mix(@first_color, @second_color, p1: p1, p2: p2)
      end

      def self.mix_multiple(_colors = [], _proportions = [])
        raise NotImplementedError
      end
    end
  end
end
