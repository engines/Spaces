require_relative 'thing'

module Spaces
  class Model < Thing

    class << self
      def universe; @universe ||= Universe.new ;end
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
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
