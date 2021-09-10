module Streaming
  module Commands
    class Import < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.import(**input, &block)
      end

    end
  end
end
