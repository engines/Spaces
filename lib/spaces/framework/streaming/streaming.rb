require_relative 'space'

module Streaming
  module Streaming

    def with_streaming(*path_elements, &block)
      stream_for(path_elements).produce(&block)
    end

    def stream_for(*path_elements)
      stream_class.new(path_elements)
    end

    def stream_class; Space ;end

  end
end
