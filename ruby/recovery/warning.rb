require_relative 'trace'

module Recovery
  module Warning
    extend Warning

    def warn(args)
      t = trace_class.new(args)
      spout("\n[WARNING]#{'-' * 88}<<<<")
      spout t.t
      spout("\n")
      spout t.array
      spout "\n"

      spout(t.error.message) if t.error

      if tw = t.witnesses
        spout "\nWitnesses#{'-' * 11}<<<<"
        spout tw.map { |w| "#{w.first}: #{w.last}" }
      end
      spout("\n")
    end

    def trace_class; Trace ;end

  end
end
