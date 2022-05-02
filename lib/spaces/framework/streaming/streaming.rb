require_relative 'space'

module Streaming
  module Streaming

    def with_streaming(&block)
      stream.clear
      stream.produce(&block)
    end

    def stream
      @stream ||= input[:stream] || stream_class.new(stream_elements)
    end

    def stream_class; Space ;end
    def stream_elements; [space.identifier, input_for(:identifier), qualifier] ;end

  end
end
