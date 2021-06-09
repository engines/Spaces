module Installing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Input
        ]
      end
    end

  end
end
