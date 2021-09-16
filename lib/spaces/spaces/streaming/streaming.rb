require_relative 'stream'

module Spaces
  module Streaming

    def stream_for(identifiable, identifier = nil)
      stream_class.new(identifiable, space: self, identifier: identifier)
    end

    # def default_identifier; super.identifier ;end
    def stream_class; Stream ;end

    def default_streaming_location; :streams ;end

  end
end
