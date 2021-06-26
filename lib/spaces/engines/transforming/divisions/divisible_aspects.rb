module Divisions
  module DivisibleAspects

    def packing_artifact_for(key)
      all_provider_aspects.map(&:packing_artifact) if keys.include?(key)
    end

    def all_provider_aspects
      all.map(&:provider_aspect)
    end

  end
end
