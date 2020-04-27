require_relative 'thing'

module Spaces
  class Model < Thing
    extend Forwardable

    class << self
      define_method (:universe) { @universal_space ||= Universal::Space.new }
      define_method (:schema) { @schema ||= schema_class.new }

      def schema_class
        require_relative("../#{namespace}/schema")
        Module.const_get("#{namespace}/schema".camelize)
      rescue LoadError
        Schema
      end
    end

    relation_accessor :descriptor

    delegate(
      [:universe, :schema, :schema_class] => :klass,
      [:outline, :deep_outline] => :schema
    )

    alias_method :product, :itself

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    define_method (:file_name) { klass.qualifier }
    define_method (:subpath) {}
    define_method (:uniqueness) { [klass.name, identifier] }
    define_method (:capture_foreign_keys) {}
    define_method (:descriptor_class) { Descriptor }

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

    def method_missing(m, *args, &block)
      if struct&.to_h&.keys&.include?(m.to_s.sub('=', '').to_sym)
        struct.send(m, *args, &block)
      else
        super
      end
    end

  end
end
