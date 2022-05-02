module Publishing
  module Commands
    class Exporting < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      protected

      def commit
        with_streaming do
          space.export(**input.merge(stream: stream))
        end
      end

    end
  end
end
