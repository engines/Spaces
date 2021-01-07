module Arenas
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes = [Associations::Dns]

      def divisions = @divisions ||= map_for(associative_classes)

      def mandatory_keys = divisions.keys
    end

    delegate(mandatory_keys: :klass)

  end
end
