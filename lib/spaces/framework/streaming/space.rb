module Streaming
  class Space < Spaces::PathSpace

    def by(command)
      stream_class_for(command).new(command)
    end

    alias_method :over, :by

    def stream_class_for(command)
      with_filing?(command) ? FileStream : OutputStream
    end

    def with_filing?(command)
      command.is_a?(Spaces::Commands::Tailing) ||
      command.input[:background]
    end

  end
end
