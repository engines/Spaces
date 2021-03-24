module Provisioning
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Container
        ]
      end

      def divisions; @divisions ||= map_for(division_classes) ;end
    end

  end
end
