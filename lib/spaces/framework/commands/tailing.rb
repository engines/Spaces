module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Spaces::Streaming

      def stream_identifier
        input_for(:stream)
      end

      protected

      def commit
        stream_for(stream_identifier, stream_identifier).consume(input_for(:callback))
      end

    end
  end
end
