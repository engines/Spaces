module Streaming
  module Commands
    class Plan < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.plan(**input, &block)
      end

    end
  end
end
