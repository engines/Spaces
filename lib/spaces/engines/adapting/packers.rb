module ProviderAspects
  class Packers < Aspect

    delegate packing_stanzas: :division

  end
end
