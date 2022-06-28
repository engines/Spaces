module Resolving
  module Packing

    def packed
      empty_pack.tap do |m|
        m.struct = builders_for(images)
        m.predecessor = self
        m.cache_identifiers!
      end if packable?
    end

    def packable?
      @packable ||= images.any? && intends_container_service?
    end

    def intends_container_service?
      !resourcer? && (container_service? || provides_no_specific_compute_service?)
    end

    def container_service?
      compute_service&.identifier&.to_sym == (:container_service)
    end

    def provides_no_specific_compute_service?
      division_keys.exclude?(:compute_service)
    end

    def packed?
      packs.exist?(identifier)
    end

    def builders_for(images); OpenStruct.new(builders: images.inflated.struct) ;end

    def packing_divisions
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)
    end

    def empty_pack; packing_class.new ;end
    def packing_class; ::Packing::Pack ;end

  end
end
