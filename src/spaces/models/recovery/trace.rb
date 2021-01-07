require_relative 'error'

I18n.load_path << Pathname(__dir__).join('i18n').glob('*.yaml')

module Recovery
  class Trace < Error

    attr_accessor :error,
      :witnesses,
      :verbosity

    def warning
      spout "\n[WARNING]#{'-' * 88}<<<<"
      spout t.t
      spout_trace
      spout_error
      spout_witnesses
      spout "\n"
    end

    def t(id = identifier); I18n.t(id, **witnesses) ;end

    def spout_trace
      spout "\n#{array.join("\n")}" if !array.empty? && verbosity&.include?(:trace)

      spout error.backtrace if verbosity&.include?(:full_trace)
    end

    def spout_error
      spout "\n#{error}" if error && verbosity&.include?(:error)
    end

    def spout_witnesses
      if verbosity&.include?(:witnesses) && tw = witnesses
        spout "\nWitnesses#{'-' * 11}<<<<"
        spout(tw.map { |w| "#{w.first}: #{w.last}" })
      end
    end

    def identifier; [:trace, zipped_nodes].join('.') ;end

    def zipped_nodes; path_nodes.zip(method_names).map{ |n| n.join('/') } ;end
    def path_nodes; array.map(&:trace_path_nodes) ;end
    def method_names; array.map(&:trace_method_name) ;end

    def array
      @array ||= (error&.backtrace || []).select do |s|
        s.include? 'Spaces' # FIX: will fail if project name changes
      end.reject do |s|
        ignorable?(s)
      end.take(2).reverse.map(&:shortened_trace_line)
    end

    def ignorable?(line)
      [
        'spaces/models/space',
        'spaces/constantizing',
        'method_missing',
      ].map { |s| line.include?(s) }.include?(true)
    end

    def spout(stuff = '-' * 88, to: STDOUT)
      to.puts stuff
    end

    def initialize(args)
      p = args.partition { |k, v| k == :error }.map(&:to_h)
      self.error = p.first[:error]
      q = p.last.partition { |k, v| k == :verbosity }.map(&:to_h)
      self.verbosity = q.first[:verbosity]
      self.witnesses = q.last
    end

  end
end


class String

  def shortened_trace_line
    split(break_text).last
  end

  def trace_method_name
    split('`').last.split("'").first.gsub(' ', '_')
  end

  def trace_path_nodes
    split('.').first.gsub('/', '::')
  end

  def break_text; '/src/' ;end # FIX: will fail if source code is not under src folder

end
