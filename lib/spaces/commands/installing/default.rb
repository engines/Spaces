module Installing
  module Commands
    class Default < Spaces::Commands::Reading

      def assembly
        @model ||= blueprint.installation_in(arena)
      end

      def blueprint
        @blueprint ||= universe.blueprints.by(blueprint_identifier)
      end

      def arena
        @arena ||= universe.arenas.by(arena_identifier)
      end

      def blueprint_identifier; input[:blueprint_identifier] ;end
      def arena_identifier; input[:arena_identifier] ;end

    end
  end
end
