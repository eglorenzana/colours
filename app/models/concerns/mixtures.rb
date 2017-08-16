# Expose the mixable interface, to create mixtures
module Mixtures
  class MixtureError < StandardError
  end
  def define_parts_for_miixtures(*arg, **options)
    _list = arg.flatten
    _main_class = self
    _mixture_class = options.fetch(:mixture_class, Mixtures::MixtureBuilder)
  end

  # Builder for mixtures
  class MixtureBuilder
    extend AssociationData
  end
end
