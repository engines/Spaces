require_relative 'saving'

module Arenas
  module Commands
    class ProviderProvisioning < Saving

      alias_method :model, :current_model

      protected

      def commit
        space.save_other_providers(model)
      end

    end
  end
end
