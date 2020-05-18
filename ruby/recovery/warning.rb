require_relative 'trace'

module Recovery
  module Warning
    extend Warning

    def warn(error, witnesses = nil)
      t = trace_class.new(error)
      spout("\n[WARNING]#{'-' * 88}<<<<")
      spout t.t
      spout("\n")
      spout t.array
      spout "\n"
      spout(error.message)

      if witnesses
        spout "\nWitnesses#{'-' * 11}<<<<"
        spout witnesses.map { |w| "#{w.first}: #{w.last}" }
      end
      spout("\n")
    end

    def trace_class; Trace ;end

  end
end
