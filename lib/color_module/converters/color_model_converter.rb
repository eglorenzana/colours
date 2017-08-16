module ColorModule
  module Converters
    class ColorModelConverter
      #FALTA hacer singleton con el modulo Singleton, verificar funcionamiento
      include BasicColorModelConverter
      def initialize(model)
        @model =  model
      end	

      def perform_conversion(model_to)
        if respond_to?("to_#{model_to}")
          send("to_#{model_to}")
        else 
          #puts "No se puede convertir a #{model_to}. Se desconoce el método."
          return nil
        end
      end

      def component_values
        @model.components.map(&:value)
      end

      def component_names
        @model.components.map(&:name)
      end	
    end
  end
end