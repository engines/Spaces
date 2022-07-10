require_relative 'filing'
require_relative 'outputting'

module Streaming
  class Space < Spaces::Space

    def initialize(streaming)
      @streaming = streaming
    end

    def streams
      @stream ||= stream_classes.map { |s| s.new(self) }
    end

    def init
      streams.each &:init
    end

    def produce(&block)
      yield(self)
    rescue => e
      logger.error(e)
      exception
    end

    def consume(callback)
      streams.each { |s| s.consume(callback) }
    end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
    end

    def close
      streams.each &:close
    end

    def output(line)
      streams.each { |s| s.output(line) }
    end

    def error(message)
      streams.each { |s| s.error(message) }
    end

    def exception
      streams.each { |s| s.exception }
    end

    def verbose?
      @streaming.input[:verbose]
    end

    protected

    def stream_classes
      [(Filing if with_filing?), (Outputting if with_outputting?)].compact
    end

    def with_outputting?
      !@streaming.is_a?(Spaces::Commands::Tailing) &&
      !@streaming.input[:background]
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
