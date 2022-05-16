module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Domains,
        ]
      end

      def division_classes
        [
          super,
          Divisions::Deployment
        ].flatten
      end
    end

  end
end
