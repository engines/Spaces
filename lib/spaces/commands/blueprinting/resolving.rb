module Blueprinting
  module Commands
    class Resolving < ::Spaces::Commands::Reading

      def arena_identifier
        input[:arena_identifier]
      end

      def model
        @model ||= super.with_embeds
      end

      def resolution
        @resolution ||= model.resolved_in(arena)
      end

      def arena
        @arena ||= universe.arenas.by(arena_identifier)
      end

      def space_name
        super || :blueprints
      end

      protected

      def commit
        universe.resolutions.save(resolution)
      end

    end
  end
end
