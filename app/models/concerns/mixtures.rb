#expose the interface of partitionable objects
module Mixtures
  class MixtureError < StandardError    
  end
  def define_parts_for_miixtures(*arg,  **options)
    list =  arg.flatten
    main_class =  self
    mixture_class =  options.fetch(:mixture_class, Mixtures::MixtureBuilder)
    
  end
  
  class MixtureBuilder
    extend AssociationData    
    
    
  end
end
