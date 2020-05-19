require_relative '../spaces/thing'

I18n.load_path << Dir["#{__dir__}/i18n/*.yaml"]

module Recovery
  class Trace < ::Spaces::Thing

    attr_accessor :error
    attr_accessor :witnesses

    def t(id = identifier); super(id, witnesses) ;end

    def identifier; [:trace, zipped_nodes].join('.') ;end

    def zipped_nodes; path_nodes.zip(method_names).map{ |n| n.join('_') } ;end
    def path_nodes; array.map(&:trace_path_nodes) ;end
    def method_names; array.map(&:trace_method_name) ;end

    def array
      @array ||= (error&.backtrace || []).select do |s|
        s.include? 'Spaces' # FIX: will fail if project name changes
      end.reject do |s|
        s.include? 'method_missing'
      end.take(2).map(&:shortened_trace_line)
    end

    def initialize(args)
      p = args.partition { |k, v| k == :error }.map(&:to_h)
      self.error = p.first[:error]
      self.witnesses = p.last
    end

  end
end


class String

  def shortened_trace_line
    split(break_text).last
  end

  def trace_method_name
    split('`').last.split("'").first
  end

  def trace_path_nodes
    split('.').first.split('/')
  end

  def break_text; '/ruby/' ;end # FIX: will fail if source code is not under ruby folder

end
