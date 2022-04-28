module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      def identifier
        input_for(:identifier)
      end

      def stream_identifier
        input_for(:stream)
      end

      def callback
        input_for(:callback, klass: Proc)
      end

      protected

      def commit
        stream_for(space, identifier, stream_identifier).consume(
          callback
        )
      end

    end
  end
end
