class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.active_model_serializer(options={})
    s_name = self.name + 'Serializer'
    s_name.safe_constantize
  end
end
