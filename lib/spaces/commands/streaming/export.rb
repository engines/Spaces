module Streaming
  module Commands
    class Export < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.export(**input, &block)
      end

    end
  end
end
