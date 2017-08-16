module ColorModule
  module Spaces  
    class ColorModelFactory
      def ColorModelFactory.get_model(model_name)
        model_class = model_name.to_s + 'Model'
        begin
          klass = parent.const_get(model_class)
          klass.new
        rescue NameError => e
          raise Spaces::ColorModelError.new(msg: 'There is not a ColorModel named ' + model_class)
        end
      end

      def ColorModelFactory.model_exists?(model_class)
        klass = parent.const_get(model_class)
        klass.is_a?(Class)
      end	
    end	
  end
end
