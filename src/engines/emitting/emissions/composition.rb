module Emissions
  class Composition < ::Spaces::Composition

    class << self
      def naming_map
        {
          anchor: :binding_anchor,
          nodules: :modules
        }
      end

      def division_classes
        [
          Divisions::Bindings,
          Divisions::Anchor,
          Divisions::Configuration,
          Divisions::Scaling,
          Divisions::OsPackages,
          Divisions::Nodules,
          Divisions::Providers,
          Divisions::Packages,
          Divisions::Images,
          Divisions::Containers
        ]
      end
    end

  end
end
