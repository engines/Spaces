require_relative 'filing'
require_relative 'outputting'

module Streaming
  class Space < Spaces::Space

    def initialize(streaming)
      @streaming = streaming
    end

    def stream
      @stream ||= stream_classes.map { |s| s.new(self) }
    end

    def stream_classes
      [Filing].tap { |s| s.push(Outputting) if with_output? }
    end

    def with_output?
      # @streaming.is_a?(Spaces::Commands::Tailing) ||
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
