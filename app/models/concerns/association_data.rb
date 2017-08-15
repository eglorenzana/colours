#expose the interface of partitionable objects
module AssociationData
  def get_association_data(main_object_klass, *list)
    association_data = Hash.new
    list.flatten.each do |l|
      name = l.to_s.split(/_part/).first.to_sym
      assoc_klass = main_object_klass.reflect_on_association(l).klass
      object_part_class = (assoc_klass.reflect_on_association(name)).klass
      association_data[l] = {
        klass: assoc_klass, 
        object_part_klass: object_part_class, 
        object_assoc_name: name
      }
    end
    association_data
  end
end