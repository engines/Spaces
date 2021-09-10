module Streaming
  module Commands
    class Apply < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.apply(**input, &block)
      end

    end
  end
end
