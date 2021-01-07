require_relative 'thing'

module Spaces
  class Model < Thing

    class << self
      def universe = @universe ||= Universe.new
    end

    delegate(universe: :klass)

    def file_name = klass.qualifier
    def uniqueness = [klass.name, identifier]

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

    def subpath = ''

  end
end
