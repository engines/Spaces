module Spaces
  class Thing
    extend Forwardable
    include ::Recovery::Warning
    extend ::Recovery::Warning

    delegate t: I18n

    class << self
      def name_elements = name.split('::')
      def nesting_elements = name_elements[0..-2]

      def identifier = name_elements.join

      def namespace = nesting_elements.join.snakize

      def qualifier = name_elements.last.snakize

      def from_yaml(y) =
        YAML::load(y, permitted_classes: [OpenStruct, Symbol])

      def relation_accessor(*args); attr_accessor(*args) ;end

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end

      def descriptor_class = Descriptor

      def subclasses =
        ObjectSpace.each_object(Class).select { |c| c < self }

      def subqualifiers = subclasses.map(&:qualifier).sort

      def klasses(inside:, inheriting:) =
        inside.constants.map { |c| inside.const_get(c) }.select {|k| k < inheriting }

      def class_for(*elements) = elements.flatten.compact.constantize
    end

    attr_accessor :struct

    delegate(
      [:identifier, :namespace, :qualifier, :name_elements, :nesting_elements, :spout, :descriptor_class, :klasses, :class_for] => :klass
    )

    alias_method :summary, :struct

    def klass = self.class

    def keys = struct&.to_h&.keys

    def context_identifier = identifier

    def has?(property) = !struct[property].nil?

    def modified_at = default_space.modified_at(self)
    def default_space = universe.send(qualifier.pluralize)

    def times(first, operator, second) =
      (first || Time.at(0)).send(operator, (second || Time.at(0)))

    def to_yaml = YAML.dump(struct)

    def to_json(*args) = to_h.to_json(*args)

    def open_struct_from_json(j) = JSON.parse(j, object_class: OpenStruct)

    def to_h = struct.to_h_deep

    def to_s = identifier

    def initialize(struct: nil)
      self.struct = duplicate(struct) || OpenStruct.new
    end

    def method_missing(m, *args, &block)
      return struct.send(m, *args, &block) if keys&.include?(m.to_s.sub('=', '').to_sym)
      return identifier.send(m, *args, &block) if identifier.respond_to?(m)
      super
    rescue TypeError
      super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m.to_s.sub('=', '').to_sym) || identifier.respond_to?(m) || super
    rescue TypeError
      super
    end

  end
end
