module Arenas
  module Commands
    class Installing < ::Arenas::Commands::Saving

      alias_method :model, :current_model

      protected

      def commit
        space.save_installations_for(model)
      end

    end
  end
end
