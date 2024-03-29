module Arenas
  module Commands
    class Resolving < ::Arenas::Commands::Saving

      alias_method :model, :current_model

      protected

      def commit
        space.save_resolutions_for(model, force: force)
      end

    end
  end
end
