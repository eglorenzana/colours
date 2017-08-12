module ColorModule
  module Spaces  
    class ColorModelFactory
      def ColorModelFactory.get_model(name)
        splitted = name.to_s.downcase.split(/model/)
        model_name = splitted.first.upcase + 'Model'
        begin
          klass = parent.const_get(model_name)
          klass.new
        rescue NameError => e
          raise Spaces::ColorModelError.new(msg: 'There is not a ColorModel named ' + model_name)
        end
      end

      def ColorModelFactory.model_exists?(name)
        begin
          splitted = name.to_s.downcase.split(/model/)
          model_name = splitted.first.upcase + 'Model'
          klass = parent.const_get(model_name)
          klass.is_a?(Class)
        rescue NameError => e
          (raise ColorModule::Spaces::ColorSpaceNotFound.new(name) )
        end
      end	
    end	
  end
end
