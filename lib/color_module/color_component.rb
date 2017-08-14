module ColorModule
  class ColorComponent
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

    def validate(value)
      (@min_value..@max_value).include?(value)
    end

    def value=(value)
      _value = value
      validate(_value) ?  (@value =  _value) :  (raise ColorComponentError.new(object: @name, value: _value))
    end

    def resume
      "#{@name}: #{@value}"
    end
    
    def eql?(another_component)
      first_part = [:class, :name].all? do |method_name|
        self.send(method_name) == another_component.send(method_name)
      end
      first_part && ((value - another_component.value).abs <= DELTA_VALUE)
    end

  end
end
