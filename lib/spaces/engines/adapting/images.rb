module ProviderAspects
  class Images < Aspect

    delegate all: :division

    def packing_stanza
      all.map(&:provider_division_aspect).map(&:packing_stanza)
    end

  end
end
