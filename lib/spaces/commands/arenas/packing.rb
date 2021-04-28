require_relative 'saving'

module Arenas
  module Commands
    class Packing < Saving

      alias_method :model, :current_model

      protected

      def commit
        model.packables.map do |p|
          ::Packing::Commands::Saving.new(identifier: p.identifier).run.result
        end
      end

    end
  end
end
