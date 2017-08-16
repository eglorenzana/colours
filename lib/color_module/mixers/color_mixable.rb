# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module ColorModule
  module Mixers
    # Interface for color mixers
    module ColorMixable
      DEFAULT_MIXER = Mixers::PhysicalColorMixer

      def mix_color(second_color, params = {})
        mixer = params[:mixer] || DEFAULT_MIXER
        mixer.mix(self, second_color, params)
      end
    end
  end
end
