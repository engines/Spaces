module Installing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Input,
          Divisions::Deployment,
          ::Arenas::Composition.associative_classes
        ].flatten
      end
    end

  end
end
