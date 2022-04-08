module Publishing
  module Commands
    class Synchronizing < ::Spaces::Commands::Saving

      protected

      def commit
        space.synchronize_with(universe.blueprints, identifier)
      end

    end
  end
end
