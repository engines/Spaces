module Blueprinting
  module Commands
    class Settling < ::Spaces::Commands::Reading

      def arena_identifier
        input[:arena_identifier]&.to_s
      end

      def model
        @model ||= super.with_embeds
      end

      def arena
        @arena ||= universe.arenas.by(arena_identifier)
      end

      def space_identifier
        super || :blueprints
      end

    end
  end
end
