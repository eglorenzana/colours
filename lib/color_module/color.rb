module ColorModule
  class Color
    alias :read_attribute_for_serialization :send
    include Comparators::ColorComparable
    include Mixers::ColorMixable
    attr_reader :model
    DELEGATE_METHODS = %i[components components_to_hash model_name resume]

    def initialize(model, *values)
      @model =  Spaces::ColorModelFactory.get_model(model)
      @model.assign_components(*values)
    end
    
    def active_model_serializer
        ColorModule::Serializers::ColorSerializer
    end

    def assign_components(*values)
      @model.assign_components(values)
    end

    def convert_to(model_to)
      new_model = @model.convert_to(model_to)
      Color.new(new_model.model_name, *(new_model.component_values))
    end

    def eql?(another_color)
      model.eql?(another_color.model)
    end

    def +(color)
      mix_color(color, 1, 1)
    end

    def mix_with(color)
      if block_given?
        yield(self, color)
      else
        +(color)
      end
    end


    DELEGATE_METHODS.each do |name|
      define_method(name) do
        model.send(name)
      end
    end

  end
end
