require_relative 'thing'
require_relative 'inflatable'

module Spaces
  class Model < Thing
    include Inflatable

    class << self
      def universe; Space.universe ;end
    end

    delegate(universe: :klass)

    def space_named(name); universe.send(name) ;end

    def file_name; klass.qualifier ;end
    def subpath; Pathname(''); end
    def uniqueness; [klass.name, identifier] ;end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

  end
end
