module Arenas
  module Packing

    def packed; present_in(packs) ;end
    
    def unpacked
      absent_in(packs).select { |b| b.resolution&.packable? }
    end

    def unsaved_packs; packables.reject(&:packed?) ;end
    def packables; bound_resolutions.select(&:packable?) ;end

  end
end
