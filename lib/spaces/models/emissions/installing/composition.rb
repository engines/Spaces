module Installing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Input,
          Divisions::Deployment
        ]
      end
    end

  end
end
