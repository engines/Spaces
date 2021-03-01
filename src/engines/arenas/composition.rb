module Arenas
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Tenant,
          Associations::Domain
        ]
      end

      def division_classes
        [
          Divisions::Bindings
        ]
      end
    end

  end
end
