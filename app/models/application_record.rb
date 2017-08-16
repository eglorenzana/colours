# Application Custom definition to subclass later the database connections
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.active_model_serializer(_options = {})
    s_name = name + 'Serializer'
    s_name.safe_constantize
  end
end
