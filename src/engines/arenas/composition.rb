module Arenas
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Tenant,
          Associations::Domain,
          Associations::Dns
        ]
      end
    end

  end
end
