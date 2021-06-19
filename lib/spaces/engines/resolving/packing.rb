module Resolving
  module Packing

    def packed
      empty_pack.tap do |m|
        m.struct = builders_for(images)
        m.cache_primary_identifiers(arena_identifier, blueprint_identifier)
      end if packable?
    end

    def packable?
      @packable ||= images.any? && (binding_target.empty? || bindings_to_here_imply_packable?)
    end

    def bindings_to_here_imply_packable?
      bindings_to_here.any?(&:implies_packable?)
    end

    def bindings_to_here
      @bindings_to_here ||= resolutions.bindings_to(self)
    end

    def builders_for(images); OpenStruct.new(builders: images.inflated.struct) ;end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

    def empty_pack; packing_class.new ;end
    def packing_class; ::Packing::Pack ;end

  end
end
