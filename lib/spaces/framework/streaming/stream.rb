module Streaming
  class Stream < Spaces::Model

    relation_accessor :command

    def segments
      command.stream_elements.flatten.map(&:identifier)
    end

    def identifier
      [:streaming, segments].flatten.join(identifier_separator)
    end

    def identifier_separator; ''.identifier_separator ;end

    def initialize(command)
      self.command = command
    end

  end
end
