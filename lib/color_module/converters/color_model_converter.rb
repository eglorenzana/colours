module ColorModule
  module Converters
    # Include the basic color model converter to arrange the
    # space color converters by inheritance of this class
    class ColorModelConverter
      # FALTA hacer singleton con el modulo Singleton, verificar funcionamiento
      include BasicColorModelConverter

      def initialize(model)
        @model = model
      end

      def perform_conversion(model_to)
        return nil unless respond_to?("to_#{model_to}")
        send("to_#{model_to}")
      end

      def component_values
        @model.component_values
      end

      def component_names
        @model.component_names
      end
    end
  end
end
