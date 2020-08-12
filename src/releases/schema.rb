require_relative '../spaces/schema'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../packing/images/images'
require_relative '../provisioning/providers/providers'

module Releases
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          title: 0,
          description: 0,
          licenses: [(1..), { label: 1, url: 1 }],
          provider: 0,
          images: 0,
          bindings: 0
        }
      end

      def naming_map
        {
          anchor: :binding_anchor
        }
      end

      def division_classes
        [
          Bindings::Bindings,
          Bindings::Anchor,
          Packing::Images::Images,
          Provisioning::Providers::Providers
        ]
      end
    end

  end
end
