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

    def intends_container_service? =
      !resourcer? && (container_service? || provides_no_specific_compute_service?)

    def container_service? =
      compute_service&.identifier&.to_sym == (:container_service)

    def provides_no_specific_compute_service? =
      division_keys.exclude?(:compute_service)

    def packed? = packs.exist?(identifier)

    def builders_for(images) =
      OpenStruct.new(builders: images.inflated.struct)

    def packing_divisions =
      divisions.select { |d| d.packing_division? }.sort_by(&:composition_rank)

    def empty_pack = packing_class.new
    def packing_class = ::Packing::Pack

  end
end
