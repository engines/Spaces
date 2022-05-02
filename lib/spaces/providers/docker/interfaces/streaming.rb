module Providers
  module Docker
    module Streaming

      def collect(io)
        stream&.collect(io) do |raw|
          j = JSON.parse(raw, symbolize_names: true)
          return j.slice(:error) if j[:error]
          {output: j[:stream]}
        end
      end

    end
  end
end
