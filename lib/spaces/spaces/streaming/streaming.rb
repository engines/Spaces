require_relative 'stream'

module Spaces
  module Streaming

    def with_streaming(identifiable, identifier = nil, &block)
      stream_for(identifiable, identifier).produce(&block)
    end

    def stream_for(identifiable, identifier = nil)
      stream_class.new(identifiable, space: space, identifier: identifier)
    end

    def stream_class; Stream ;end

    def default_streaming_location; :streams ;end

  end
end
