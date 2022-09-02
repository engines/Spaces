module Spaces
  class Model < Thing

    class << self
      def universes
        @@universes ||= ::Universes::Multiverse.new
      end
    end

    delegate(universes: :klass)

    #FIX -- should derive universe from the context of a model's enclosing space
    def universe = universes.universe
    def cache = universes.cache

    def space_named(name) = universe.send(name)

  end
end
