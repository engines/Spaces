require_relative '../spaces/schema'

module Releases
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          title: 0,
          description: 0,
          licenses: [(1..), { label: 1, url: 1 }],
          bindings: 0,
        }
      end

      def naming_map
        {
        }
      end

      def division_classes
        [
        ]
      end
    end

  end
end
