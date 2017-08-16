module ColorModule
  # Components for the color models
  class ColorComponent
    alias read_attribute_for_serialization send
    DELTA_VALUE = 0.01
    attr_reader :value, :name
    attr_reader :min_value
    attr_reader :max_value

    def initialize(name, *limit)
      @name = name.to_sym
      @min_value = limit.flatten.min
      @max_value = limit.flatten.max
      @value = @min_value
    end

    def active_model_serializer
      ColorModule::Serializers::ColorComponentSerializer
    end

    def validate(value)
      (@min_value..@max_value).cover?(value)
    end

    def value=(value)
      validate(value) ? @value = value : (raise ColorComponentError, object: @name, value: value)
    end

    def resume
      "#{@name}: #{@value}"
    end

    def to_h
      { @name => @value }
    end

    def eql?(other)
      first_part = %i[class name].all? do |method_name|
        send(method_name) == other.send(method_name)
      end
      first_part && ((value - other.value).abs <= DELTA_VALUE)
    end
  end
end
