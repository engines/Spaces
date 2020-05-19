require_relative 'trace'

module Recovery
  module Warning
    extend Warning

    def warn(args)
      t = trace_class.new(args)
      spout("\n[WARNING]#{'-' * 88}<<<<")
      spout t.t

      spout("\n#{t.array.join("\n")}") unless t.array.empty?

      spout("\n#{t.error.message}") if t.error

      if tw = t.witnesses
        spout "\nWitnesses#{'-' * 11}<<<<"
        spout tw.map { |w| "#{w.first}: #{w.last}" }
      end
      spout("\n")
    end

    def trace_class; Trace ;end

  end
end
