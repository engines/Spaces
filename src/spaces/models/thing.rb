module Spaces
  class Thing
    extend Forwardable

    require_level 'spaces/models/recovery'

    include ::Recovery::Warning
    extend ::Recovery::Warning

    delegate t: I18n

    class << self
      def identifier; name.split('::').join ;end
      def namespace; name.split('::')[0..-2].join.snakize ;end
      def qualifier; name.split('::').last.snakize ;end
      def from_yaml(y); YAML::load(y) ;end

      def relation_accessor(*args); attr_accessor(*args) ;end

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end

      def klasses(inside:, inheriting:)
        inside.constants.map { |c| inside.const_get(c) }.select {|k| k < inheriting }
      end
    end

    attr_accessor :struct, :klass

    delegate(
      [:identifier, :namespace, :qualifier, :spout, :klasses] => :klass,
      to_h: :struct
    )

    def klass; @klass ||= self.class ;end
    def keys; struct&.to_h&.keys ;end
    def emit; duplicate(struct) ;end

    def context_identifier; identifier ;end
    def to_yaml; YAML.dump(struct) ;end
    def to_json(*args); struct&.to_h_deep&.to_json(*args) ;end
    def open_struct_from_json(j); JSON.parse(j, object_class: OpenStruct) ;end

    def to_s; identifier ;end

    def initialize(struct: nil)
      self.struct = struct
    end

    def method_missing(m, *args, &block)
      if keys&.include?(m.to_s.sub('=', '').to_sym)
        struct.send(m, *args, &block)
      else
        super
      end
    rescue TypeError
      super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m.to_s.sub('=', '').to_sym) || super
    rescue TypeError
      super
    end

  end
end
