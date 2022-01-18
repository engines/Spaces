module Installing
  class Space < ::Settling::Space

    class << self
      def default_model_class
        Installation
      end
    end

    def cascade_deletes; [:resolutions] ;end

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
