module Publishing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Input
        ] + super
      end
    end

  end
end
