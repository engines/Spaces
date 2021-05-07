require_relative 'saving'

module Arenas
  module Commands
    class RuntimeBooting < Saving

      alias_method :model, :current_model

      protected

      def commit
        space.save_initial(model)
        space.save_runtime(model)
      end

    end
  end
end
