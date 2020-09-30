require_relative '../spaces/models/composition'
require_relative 'divisions/provisioners/provisioners'
require_relative 'divisions/post_processors/post_processors'

module Packing
  class Composition < ::Spaces::Composition

    class << self
      def division_classes
        [
          Provisioners::Provisioners,
          PostProcessors::PostProcessors
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
