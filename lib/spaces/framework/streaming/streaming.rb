require_relative 'space'

module Streaming
  module Streaming

    def with_streaming(&block)
      stream.init
      stream.produce(&block)
    ensure
      stream.close
    end

    def stream
      @stream ||= input[:stream] || stream_class.new(self).stream
    end

    def stream_class; Space ;end

    def stream_elements
      [ space.identifier,
        input_for(:identifier),
        qualifier,
        input_for(:timestamp)
      ]
    end

  end
end
