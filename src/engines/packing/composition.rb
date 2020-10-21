module Packing
  class Composition < ::Emissions::Composition

    class << self
      def division_classes
        [
          Divisions::Provisioners,
          Divisions::PostProcessors
        ]
      end

      def naming_map
        {
          post_processors: 'post-processors'
        }
      end

      def divisions; @divisions ||= map_for(division_classes) ;end
    end

  end
end
