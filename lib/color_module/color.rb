module ColorModule 
  class Color
    alias :read_attribute_for_serialization :send
    include Comparators::ColorComparable
    include Mixers::ColorMixable
    attr_reader :model
    def initialize(model, *values)
      @model =  Spaces::ColorModelFactory.get_model(model)
      @model.assign_components(*values)
    end
    def active_model_serializer
        ColorModule::Serializers::ColorSerializer
    end   
    def components
      @model.components
    end
    def components_to_hash
      @model.components_to_hash
    end

    def model_name
      @model.model_name
    end

    def resume
      @model.resume
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

    def method_missing(method, *args)
      _possible_accessor_methods  = @model.component_names + @model.component_names.map{|name| "#{name}=".to_sym}
      if _possible_accessor_methods.include?(method)
        @model.send(method, *args)
      else
        super
      end
    end	

    def self.mix_colors(color1, n1, color2, n2)

    end
  end

end
