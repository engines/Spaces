module Commissioning
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Milestones
        ]
      end
    end

  end
end
