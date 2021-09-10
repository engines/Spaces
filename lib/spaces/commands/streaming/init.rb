module Streaming
  module Commands
    class Init < ::Spaces::Commands::Command

      def space_identifier
        super || :streaming
      end

      protected

      def commit(&block)
        space.init(**input, &block)
      end

    end
  end
end
