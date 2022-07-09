require_relative 'filing'
require_relative 'outputting'

module Streaming
  class Space < Spaces::Space

    def initialize(streaming)
      @streaming = streaming
    end

    def stream = stream_class.new(@streaming)

    def stream_class = with_filing? ? Filing : Outputting

    def with_filing? = (
      @streaming.is_a?(Spaces::Commands::Tailing) ||
      @streaming.input[:background] )

  end
end
