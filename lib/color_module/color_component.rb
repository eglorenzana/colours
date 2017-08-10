# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ColorModule
  class ColorComponent
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
      _value = value.to_f
      validate(_value) ?  (@value =  _value) :  (raise ColorComponentError.new(object: @name, value: _value))
    end

    def resume
      "#{@name}: #{@value}"
    end

  end
  class ColorComponentError < StandardError
    def initialize(params={})
      default_params = {msg: 'Range value error in ColorComponent'}.merge(params)
      data_msg = 
        params[:object] ? 
        " while trying to assign #{params.fetch(:value, '')} to #{params[:object]}" : ''
      super(default_params.fetch(:msg, '') + data_msg)
    end
  end
end
