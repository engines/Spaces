module Arenas
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Domains,
          Associations::Connections
        ]
      end

      def division_classes
        [
          Arenas::Input,
          Divisions::Bindings,
          Divisions::About
        ]
      end
    end

  end
end
