require_relative '../../spaces/models/composition'
require_relative '../divisions/bindings/bindings'
require_relative '../divisions/bindings/anchor'
require_relative '../divisions/configuration'
require_relative '../divisions/scaling'
require_relative '../divisions/os_packages'
require_relative '../divisions/nodules/nodules'
require_relative '../divisions/packages/packages'
require_relative '../divisions/providers/providers'
require_relative '../divisions/images/images'
require_relative '../divisions/containers/containers'

module Emissions
  class Composition < ::Spaces::Composition

    class << self
      def naming_map
        {
          anchor: :binding_anchor
        }
      end

      def division_classes
        [
          Bindings::Bindings,
          Bindings::Anchor,
          Divisions::Configuration,
          Divisions::Scaling,
          Divisions::OsPackages,
          Nodules::Nodules,
          Providers::Providers,
          Packages::Packages,
          Packing::Images::Images,
          Provisioning::Containers::Containers
        ]
      end
    end

  end
end
