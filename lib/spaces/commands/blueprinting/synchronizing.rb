module Blueprinting
  module Commands
    class Synchronizing < ::Spaces::Commands::Saving

      protected

      def commit
        space.synchronize_with(universe.publications, identifier)
      end

    end
  end
end
