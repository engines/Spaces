module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Spaces::Streaming

      def identifier
        input_for(:identifier)
      end

      def stream_identifier
        input_for(:stream)
      end

      protected

      def commit
        stream_for(identifier, stream_identifier).consume(input_for(:callback))
      end

    end
  end
end
