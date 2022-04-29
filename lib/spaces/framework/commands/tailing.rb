module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      protected

      def commit
        stream_for(space, identifier, stream_identifier).
          consume(callback)
      end

    end
  end
end
