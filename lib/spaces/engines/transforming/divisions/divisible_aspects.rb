module Divisions
  module DivisibleAspects

    def packing_snippet_for(key)
      all_provider_division_aspects.map(&:packing_snippet) if keys.include?(key)
    end

    def all_provider_division_aspects
      all.map(&:provider_division_aspect)
    end

  end
end
