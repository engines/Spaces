require_relative '../spaces/schema'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../terraform/providers/provider'

module Releases
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          title: 0,
          description: 0,
          licenses: [(1..), { label: 1, url: 1 }],
          provider: 1,
          bindings: 0,
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
          Terraform::Providers::Provider,
          Images::Image
        ]
      end
    end

  end
end
