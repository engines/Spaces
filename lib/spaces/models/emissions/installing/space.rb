module Installing
  class Space < ::Settling::Space

    class << self
      def default_model_class
        Installation
      end
    end

    def cascade_deletes; [:resolutions] ;end

    def summaries(arena_identifier:)
      all(arena_identifier: arena_identifier).map(&:summary)
    end

    def all(arena_identifier:)
      identifiers(arena_identifier: arena_identifier).map { |i| by(i) }
    end

    def identifiers(arena_identifier:)
      universe.arenas.by(arena_identifier).installation_map.values.map(&:identifier)
    end

    def by(identifiable)
      super
    rescue Spaces::Errors::LostInSpace => e
      blueprint_for(identifiable).installation_in(arena_for(identifiable))
    end

    def blueprint_for(identifiable)
      blueprints.by(identifiable.low)
    end

    def arena_for(identifiable)
      arenas.by(identifiable.high)
    end

  end
end
