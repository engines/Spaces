module Blueprinting
  module Commands
    class Synchronizing < ::Spaces::Commands::Saving

      def space_name
        super || :blueprints
      end

      protected

      def commit
        space.synchronize_with(universe.publications, identifier)
      end

    end
  end
end
