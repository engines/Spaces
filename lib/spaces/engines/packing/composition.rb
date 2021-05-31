module Packing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Images,
          Divisions::Packers
        ]
      end

      def naming_map
        {
          images: 'builders',
          packers: 'provisioners'
        }
      end

      def divisions; @divisions ||= map_for(division_classes) ;end
    end

  end
end
