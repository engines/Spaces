require_relative '../spaces/schema'
require_relative 'post_processors/post_processors'

module Packing
  class Schema < ::Spaces::Schema

    class << self
      def division_classes
        [
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
