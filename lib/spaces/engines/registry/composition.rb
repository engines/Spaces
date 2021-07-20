module Registry
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Bindings
        ]
      end
    end

  end
end
