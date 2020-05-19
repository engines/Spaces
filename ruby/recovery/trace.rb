require_relative '../spaces/thing'

I18n.load_path << Dir["#{__dir__}/i18n/*.yaml"]

module Recovery
  class Trace < ::Spaces::Thing

    attr_accessor :error
    attr_accessor :witnesses

    def t(id = identifier); super(id, witnesses) ;end

    def identifier; [:trace, path_nodes.zip(method_names)].flatten.join('.') ;end

    def path_nodes; array.map(&:trace_path_nodes) ;end
    def method_names; array.map(&:trace_method_name) ;end

    def array
      @array ||= error.backtrace.select do |s|
        s.include? 'Spaces' # FIX: will fail if project name changes
      end.reject do |s|
        s.include? 'method_missing'
      end.take(2)
    end

    def initialize(args)
      p = args.partition { |k, v| k == :error }.map(&:to_h)
      self.error = p.first[:error]
      self.witnesses = p.last
    end

  end
end


class String

  def trace_method_name
    split('`').last.split("'").first
  end

  def trace_path_nodes
    split('.').first[break_point .. -1].split('/')
  end

  def break_point; index(break_text) + break_text.length ;end
  def break_text; '/ruby/' ;end # FIX: will fail if source code is not under ruby folder

end
