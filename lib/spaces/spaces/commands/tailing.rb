module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Spaces::Streaming

      def stream_identifier
        input[:stream]
      end

      protected

      def commit
        stream_for(stream_identifier, stream_identifier).consume
      end

    end
  end
end
