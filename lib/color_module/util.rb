module ColorModule
  # Manage the interaction between the ColorModule and Controllers
  class Util
    def self.spaces_defined
      # ObjectSpace.each_object(::Class).select { |klass| klass <= ColorModule::Spaces::ColorModel}
      [
        ColorModule::Spaces::LABModel,
        ColorModule::Spaces::RGBModel,
        ColorModule::Spaces::XYZModel,
        ColorModule::Spaces::CMYKModel
      ]
    end

    def self.spaces_defined_hash
      spaces_defined.map { |c| [c.new.model_name.downcase, c] }.to_h
    end

    def self.comparator_defined
      [ColorModule::Comparators::CMCComparator]
    end

    def self.comparator_defined_hash
      comparator_defined.map { |c| [c.class_variable_get('@@comparator_name').downcase, c] }.to_h
    end

    def self.get_comparator(name)
      comparator_defined_hash[name.to_sym]
    end

    def self.color_space?(name)
      ColorModule::Spaces::ColorModelFactory.model_exists?(name)
    end

    def self.get_components(from_space, components)
      model = ColorModule::Spaces::ColorModelFactory.get_model(from_space)
      c = []
      case components
      when Array then
        c = components.first(model.component_names.size)
      when Hash, ActionController::Parameters then
        c = model.component_names.map { |n| components[n.downcase.to_s] }
      else
        raise ColorModule::ColorComponentError, msg: "Components given are not valid: #{components}"
      end
      c.compact!
      return c.map(&:to_f) if c.size == model.components.size
      raise ColorModule::ColorComponentError,
            msg: "Wrong number of components: given #{c.size}, but was expected #{model.component_names.size}"
    end

    def self.parse_data_from_color_converted(color1, color2)
      color2.instance_variable_set('@from_color', color1)
      color2
    end

    def self.perform_conversion(from_space, to_space, components)
      color_space?(from_space)
      color_space?(to_space)
      processed_components = get_components(from_space, components)
      color = ColorModule::Color.new(from_space, *processed_components)
      color_converted = color.convert_to(to_space)
      parse_data_from_color_converted(color, color_converted)
    end

    def self.perform_comparation(comparator_name, space, color1_data, color2_data, options = {})
      color_space?(space)
      comparator =
        get_comparator(comparator_name) ||
        (raise ColorModule::Comparators::ColorComparatorError, name: comparator_name)
      comp_color1 = get_components(space, color1_data)
      comp_color2 = get_components(space, color2_data)
      color1 = ColorModule::Color.new(space, *comp_color1)
      color2 = ColorModule::Color.new(space, *comp_color2)
      color1.compare_with(color2, options.merge(comparator: comparator))
    end
  end
end
