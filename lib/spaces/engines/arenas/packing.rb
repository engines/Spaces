module Arenas
  module Packing

    def unpacked
      deep_connect_bindings.reject do |b|
        packs.exist?(b.settlement_identifier_in(self))
      end
    end

    def packables; bound_resolutions.select(&:packable?) ;end

    def unsaved_packs; packables.reject(&:packed?) ;end

  end
end
