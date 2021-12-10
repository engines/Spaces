module Arenas
  module GoldenPacking

    def golden_pack_identifiers
      golden_image_divisions.map do |g|
        packs.identifiers(blueprint_identifier: g.identifier)
      end.flatten
    end

    def golden_image_divisions
      all_image_divisions.select_uniq(&:potentially_golden?)
    end

    def all_image_divisions
      bound_resolutions.map(&:images).map(&:all).flatten
    end

  end
end
