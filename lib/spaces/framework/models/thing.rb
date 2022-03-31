module Spaces
  class Thing
    extend Forwardable

    include ::Recovery::Warning
    extend ::Recovery::Warning

    delegate t: I18n

    class << self
      def name_elements; name.split('::') ;end
      def nesting_elements; name_elements[0..-2] ;end

      def identifier; name_elements.join ;end

      def namespace; nesting_elements.join.snakize ;end

      def qualifier; name_elements.last.snakize ;end

      def from_yaml(y); YAML::load(y) ;end

      def relation_accessor(*args); attr_accessor(*args) ;end

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end

      def descriptor_class; Descriptor ;end

      def subclasses
        @@subclasses ||= ObjectSpace.each_object(Class).select { |c| c < self }
      end

      def subqualifiers
        @@subqualifiers ||= subclasses.map(&:qualifier).sort
      end

      def klasses(inside:, inheriting:)
        inside.constants.map { |c| inside.const_get(c) }.select {|k| k < inheriting }
      end

      def class_for(*elements); elements.flatten.constantize ;end
    end

    attr_accessor :struct

    delegate(
      [:identifier, :namespace, :qualifier, :name_elements, :nesting_elements, :spout, :descriptor_class, :klasses, :class_for] => :klass
    )

    alias_method :summary, :struct

    def klass; self.class ;end

    def keys; struct&.to_h&.keys ;end

    def context_identifier; identifier ;end

    def times(first, operator, second)
      (first || Time.at(0)).send(operator, (second || Time.at(0)))
    end

    def to_yaml; YAML.dump(struct) ;end

    def to_json(*args); to_h.to_json(*args) ;end

    def open_struct_from_json(j); JSON.parse(j, object_class: OpenStruct) ;end

    def to_h; struct.to_h_deep ;end

    def to_s; identifier ;end

    def initialize(struct: nil)
      self.struct = duplicate(struct) || OpenStruct.new
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
