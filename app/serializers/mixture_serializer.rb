class MixtureSerializer < ActiveModel::Serializer
  attributes :name, :space, :parts, :recipe
  
  def space
    c = ColorModule::Color.new(:LAB, object.components)
    ColorModule::Serializers::ColorModelSerializer.new(c.model, instance_options)
  end
  
  def parts
    info  = object.part_managers.map do |manager|
      options_for_parts = {skip_color_assoc: true}
      data = manager.recipe.map do |part, percentage|
        {percentage: percentage}.merge(part.class.active_model_serializer(mixture: true).new(part, options_for_parts).to_hash)
      end  
      {manager.object_assoc_name.to_s.pluralize => data} unless data.empty?
    end
    info.compact.reduce(:merge)
  end
  
  def recipe
    object.recipe.to_string
  end
  
  def link
    Rails.application.routes.url_helpers.mixture_url(id: object.id, only_path: true)
  end
end
