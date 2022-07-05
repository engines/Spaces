module Resolving
  module Commands
    class Default < Spaces::Commands::Reading

      def assembly
        @model ||= blueprint.resolution_in(arena, binding)
      end

      def blueprint
        @blueprint ||= universe.blueprints.by(blueprint_identifier)
      end

      def arena
        @arena ||= universe.arenas.by(arena_identifier)
      end

      def blueprint_identifier = input_for(:blueprint_identifier)
      def arena_identifier = input_for(:arena_identifier)

    end
  end
end
