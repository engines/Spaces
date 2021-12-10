module Arenas
  module GoldenPacking

    def golden_image_divisions
      all_image_divisions.select_uniq(&:potentially_golden?)
    end

    def all_image_divisions
      bound_resolutions.map(&:images).map(&:all).flatten
    end

  end
end
