module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Domain,
          Associations::Tenant
        ]
      end
    end

  end
end
