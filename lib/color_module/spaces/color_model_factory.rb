module ColorModule
  module Spaces
    # Factory  for color model
    class ColorModelFactory
      def self.get_model(name)
        splitted = name.to_s.downcase.split(/model/)
        model_name = splitted.first.upcase + 'Model'
        begin
          klass = parent.const_get(model_name)
          klass.new
        rescue NameError => _e
          raise Spaces::ColorModelError, msg: 'There is not a ColorModel named ' + model_name
        end
      end

      def self.model_exists?(name)
        splitted = name.to_s.downcase.split(/model/)
        model_name = splitted.first.upcase + 'Model'
        klass = parent.const_get(model_name)
        klass.is_a?(Class)
      rescue NameError => _e
        raise ColorModule::Spaces::ColorSpaceNotFound, name
      end
    end
  end
end
