module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          ::Arenas::Composition.associative_classes,
          super,
          Divisions::Deployment
        ].flatten
      end
    end

  end
end
