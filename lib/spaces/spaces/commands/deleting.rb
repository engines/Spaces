require_relative 'reading'

module Spaces
  module Commands
    class Deleting < ::Spaces::Commands::Reading

      def commit
        struct.result = space.delete(model)
      end

    end
  end
end
