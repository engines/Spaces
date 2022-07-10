require_relative 'trace'

module Recovery
  module Warning
    extend Warning

    def warn(args={})
      trace_class.new(args).tap do |t|
        unless t.verbosity&.include?(:silence)
          t.spout "\n[WARNING]#{'-' * 88}<<<<"
          t.spout_translation
          t.spout_trace
          t.spout_error
          t.spout_witnesses
          t.spout "\n"
        end
      end
    end

    def trace_class = Trace

  end
end
