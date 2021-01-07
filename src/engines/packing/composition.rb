module Packing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Packers,
          Divisions::PostProcessors
        ]
      end

      def naming_map
        {
          packers: 'provisioners',
          post_processors: 'post-processors'
        }
      end

      def divisions = @divisions ||= map_for(division_classes)
    end

  end
end
