require_relative 'stream'

module Spaces
  module Streaming

    def with_streaming(identifiable, identifier = nil, &block)
      stream_for(identifiable, identifier).produce(&block)
    end

    def stream_for(identifiable, identifier = nil)
      stream_class.new(identifiable, identifier: identifier)
    end

    def stream_class; Stream ;end

  end
end
