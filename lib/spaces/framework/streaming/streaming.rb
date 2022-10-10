module Streaming
  module Streaming

    def with_streaming(&block)
      stream.init
      stream.produce(&block)
    ensure
      stream.close
    end

    def stream = input[:stream] || universe.streaming.over(self)

    def stream_elements =
      [ space.identifier,
        input_for(:identifier),
        qualifier,
        timestamp
      ]

  end
end
