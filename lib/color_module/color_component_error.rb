module ColorModule
  # Error class for model's color components
  class ColorComponentError < StandardError
    def initialize(params = {})
      default_params = { msg: 'Range value error in ColorComponent' }.merge(params)
      obj = params.fetch(:object, '')
      value = params.fetch(:value, '')
      data_msg = obj && value ? " while trying to assign #{value} to #{obj}" : ''
      super(default_params.fetch(:msg, '') + data_msg)
    end
  end
end
