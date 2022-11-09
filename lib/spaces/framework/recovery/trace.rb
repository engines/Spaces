require_relative 'error'

I18n.load_path << Pathname(__dir__).join('i18n').glob('*.yaml')

module Recovery
  class Trace < Error

    attr_accessor :args

    def translation(id = identifier)
      @translation ||= I18n.t(id, **witnesses)
    end

    def identifier =
      [:trace, context, specifier].flatten.compact.map(&:downcase).map(&:underscore).join('.')

    def error = args.error
    def specifier = args.method
    def context = args.context
    def verbosity = args.verbosity
    def witnesses = args.to_h.without(:error, :context, :method, :verbosity)

    def spout_translation(id = identifier)
      t = translation(id)
      spout t
      spout error.backtrace if error && t.include?('translation missing')
    end

    def spout_trace
      spout error.backtrace if error && verbosity&.include?(:trace)
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

    def spout(stuff = '-' * 88, to: STDOUT)
      to.puts stuff
    end

    def initialize(args)
      self.args = OpenStruct.new(args)
    end

  end
end
