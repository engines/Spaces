module Arenas
  module Packing

    def packables; bound_resolutions.select(&:packable?) ;end

    def unsaved_packs; packables.reject(&:packed?) ;end

  end
end
