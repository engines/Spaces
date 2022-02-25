module Settling
  class Space < ::Emissions::Space

    delegate([:blueprints, :arenas] => :universe)

    def by(settlement)
      super.tap do |m|
        m.arena = arenas.by(m.arena_identifier)
      end
    end

    def summaries(arena_identifier:)
      all(arena_identifier: arena_identifier).map(&:summary)
    end

    def all(arena_identifier:)
      identifiers(arena_identifier: arena_identifier).map { |i| exist_then_by(i) }.compact
    end

    def identifiers(arena_identifier:)
      universe.arenas.by(arena_identifier).resolution_map.values.map(&:identifier)
    end

  end
end
