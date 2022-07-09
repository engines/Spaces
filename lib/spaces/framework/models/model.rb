require_relative 'thing'
require_relative 'inflatable'

module Spaces
  class Model < Thing
    include Asserting
    include Inflatable

    class << self
      def universe = Space.universe
    end

    delegate(universe: :klass)

    def space_named(name) = universe.send(name)

    def file_name = klass.qualifier
    def subpath = Pathname('')
    def uniqueness = [klass.name, identifier]

    def namespaced_name(namespace, symbol) =
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"

  end
end
