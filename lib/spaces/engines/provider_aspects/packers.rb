require_relative 'aspect'

module ProviderAspects
  class Packers < Aspect

    delegate packing_stanzas: :division

  end
end
