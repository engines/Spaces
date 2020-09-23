module Recovery
  module Warning
    extend Warning

    def warn(args)
      t = trace_class.new(args)
      spout "\n[WARNING]#{'-' * 88}<<<<"
      spout t.t
      t.spout_trace
      t.spout_error
      t.spout_witnesses
      spout "\n"
    end

    def trace_class; Trace ;end

  end
end
