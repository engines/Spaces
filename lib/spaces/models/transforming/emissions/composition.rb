module Emissions
  class Composition < ::Spaces::Thing

    class << self

      def naming_map = {target: :binding_target}

      def division_classes =
        [
          Divisions::Bindings,
          Divisions::Target,
          Divisions::Resources,
          Divisions::ComputeService,
          Divisions::SystemPackages,
          Divisions::BundledPackages,
          Divisions::ManagedPackages,
          Divisions::Repositories,
          Divisions::Permissions,
          Divisions::Dimensions,
          Divisions::Ports,
          Divisions::Volumes,
          Divisions::About
        ]

      def associative_classes = []

      def ranking = [division_classes, associative_classes].flatten.compact

      def divisions = map_for(division_classes)

      def associations = map_for(associative_classes)

      def map_for(classes)
        classes.inject({}) do |m, k|
          m.tap { m[key_for(k)] = k }
        end
      end

      def key_for(klass) = mapped_key_for(klass.qualifier.to_sym)

      def mapped_key_for(key) = naming_map[key] || key
    end

    delegate([:divisions, :associations, :ranking, :naming_map] => :klass)

    def keys
      @keys ||= associations.keys + divisions.keys
    end

    def associations_and_divisions = associations.merge(divisions)

  end
end
