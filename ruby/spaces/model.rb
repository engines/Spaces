require_relative 'thing'

module Spaces
  class Model < Thing
    extend Forwardable

    class << self
      def universe
        @@universal_space ||= Universal::Space.new
      end
    end

    attr_accessor :struct
    relation_accessor :schema, :descriptor

    alias_method :product, :itself

    delegate(
      [:universe, :qualifier] => :klass,
      outline: :schema,
      to_h: :struct
    )

    def schema
      @schema ||= schema_class.new
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def context_identifier
      identifier
    end

    def file_name
      klass.qualifier
    end

    def subpath; end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

    def uniqueness
      [klass.name, identifier]
    end

    def schema_class; end

    def descriptor_class
      Descriptor
    end

    def initialize(struct: nil)
      self.struct = struct
    end

    def capture_foreign_keys; end

    def method_missing(m, *args, &block)
      if struct&.to_h&.keys&.include?(m)
        struct.send(m, *args, &block)
      else
        super
      end
    end

  end
end
