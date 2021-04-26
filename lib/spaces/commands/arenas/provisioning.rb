require_relative 'saving'

module Arenas
  module Commands
    class Provisioning < Saving

      alias_method :model, :current_model

      protected

      def commit
        model.provisionables.map do |p|
          ::Provisioning::Commands::Saving.new(identifier: p.identifier).run.result
        end
      end

    end
  end
end
