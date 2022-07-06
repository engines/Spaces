module Arenas
  module Packing

    def all_packs
      packs.identifiers(arena_identifier: identifier).map do |i|
        packs.by(i)
      end
    end

    def packed = present_in(packs)

    def unpacked =
      absent_in(packs).select { |b| b.resolution&.packable? }

    def unsaved_packs = packables.reject(&:packed?)
    def packables = bound_resolutions.select(&:packable?)

  end
end
