module Spaces
  class Space < Model

    class << self
      def universes; @@universes ||= ::Universes::Space.new ;end

      def universe; universes.universe ;end
    end

    delegate(universes: :klass)
  end
end
