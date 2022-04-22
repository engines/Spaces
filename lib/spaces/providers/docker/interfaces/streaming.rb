module Providers
  module Docker
    module Streaming

      def collect(io)
        stream_on(:build).collect(io) do |raw|
          event = JSON.parse(raw, symbolize_names: true)
          return event.slice(:error) if event[:error]
          {output: event[:stream]}
        end
      end

      def stream_on(identifier)
        stream_for(:packs, pack, identifier)
      end

    end
  end
end
