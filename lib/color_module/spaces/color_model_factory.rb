# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  module Spaces  
    class ColorModelFactory
      def ColorModelFactory.get_model(model_name)
        @model_name =  model_name
        @model_class = @model_name.to_s + 'Model'
        if model_exists?
          klass = parent.const_get(@model_class)
          return klass.new
        end
      end

      def ColorModelFactory.model_exists?
        klass = parent.const_get(@model_class)
        return klass.is_a?(Class)
      end	
    end	
  end
end
