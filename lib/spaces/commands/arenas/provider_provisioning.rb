require_relative 'saving'

module Arenas
  module Commands
    class ProviderProvisioning < Saving

      alias_method :model, :current_model

      protected

      def commit
        space.save_subordinate_providers(model)
      end

    end
  end
end
