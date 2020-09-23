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
