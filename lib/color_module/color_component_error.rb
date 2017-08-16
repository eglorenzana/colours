module ColorModule
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
