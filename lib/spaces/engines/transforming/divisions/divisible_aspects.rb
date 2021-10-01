module Divisions
  module DivisibleAspects

    def packing_stanza_for(key)
      all_provider_division_aspects.map(&:packing_stanza) if keys.include?(key)
    end

    def all_provider_division_aspects
      all.map(&:provider_division_aspect)
    end

  end
end
