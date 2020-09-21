require_relative 'thing'

module Spaces
  class Model < Thing

    class << self
      def universe; @universal_space ||= Universal::Space.new ;end
      def composition; @composition ||= composition_class.new ;end

      def composition_class
        pp '=' * 88
        pp namespace
        pp "#{namespace}/composition".camelize
        require_relative("../../#{namespace}/composition")
        Module.const_get("#{namespace}/composition".camelize)
      rescue LoadError => e
        warn(error: e, namespace: namespace, subsitution: Composition, verbosity: [:error])
        Composition
      end
    end

    relation_accessor :descriptor

    delegate(
      [:universe, :composition, :composition_class] => :klass
    )

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def file_name; klass.qualifier ;end
    def subpath; end
    def uniqueness; [klass.name, identifier] ;end
    def descriptor_class; Descriptor ;end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

  end
end
