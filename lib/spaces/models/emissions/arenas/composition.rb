module Arenas
  class Composition < ::Emissions::Composition
    # TODO: review the differences between divisions & associations


    class << self
      def associative_classes
        [
          Associations::RoleProviders,
          Associations::Domains,
          Associations::Connections
        ]
      end

      def division_classes
        [
          Arenas::Input,
          Divisions::Bindings,
          Divisions::Images,
          Divisions::About
        ]
      end
    end

  end
end
