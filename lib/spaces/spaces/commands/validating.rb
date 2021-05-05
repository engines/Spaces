require_relative 'reading'

module Spaces
  module Commands
    class Validating < ::Spaces::Commands::Reading

      protected

      def _result
        struct.result = identifier
        if (ic = model.incomplete_divisions).any?
          struct.errors = {incomplete_divisions: ic.map(&:qualifier)}
        end
      end

    end
  end
end
