module Outputting
  module Commands
    class Execution < ::Spaces::Commands::Command

      def space_identifier
        super || :outputting
      end

      protected

      def commit(&block)
        space.execution(**input, &block)
      end

    end
  end
end
