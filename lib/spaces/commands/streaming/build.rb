module Streaming
  module Commands
    class Build < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.build(**input, &block)
      end

    end
  end
end
