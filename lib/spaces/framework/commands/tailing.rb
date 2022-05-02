module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      def stream_elements; [space.identifier, input_for(:identifier), stream_identifier] ;end

      protected

      def commit
        stream.consume(callback)
      end

    end
  end
end
