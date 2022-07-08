module Blueprinting
  module Commands
    class Settling < ::Spaces::Commands::Reading

      def arena_identifier = input_for(:arena_identifier)

      def arena
        @arena ||= universe.arenas.by(arena_identifier)
      end

    end
  end
end
