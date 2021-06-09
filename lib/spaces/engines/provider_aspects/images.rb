require_relative 'aspect'

module ProviderAspects
  class Images < Aspect

    delegate all: :division

    def packing_artifact
      all.map(&:provider_aspect).map(&:packing_artifact)
    end

  end
end
