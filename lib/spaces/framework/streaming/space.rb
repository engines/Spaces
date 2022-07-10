module Streaming
  class Space < Spaces::Space

    def initialize(streaming)
      @streaming = streaming
    end

    attr_reader :streaming

    def stream
      @stream ||= stream_class.new(self)
    end

    protected

    def stream_class
      with_filing? ? Filing : Outputting
    end

    def with_filing?
      @streaming.is_a?(Spaces::Commands::Tailing) ||
      @streaming.input[:background]
    end

    def segments
      @streaming.stream_elements.flatten.map(&:identifier)
    end

    def identifier
      [:streaming, segments].flatten.join(identifier_separator).as_path
    end

    def identifier_separator; ''.identifier_separator ;end

  end
end
