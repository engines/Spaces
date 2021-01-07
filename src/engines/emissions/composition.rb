module Emissions
  class Composition < ::Spaces::Thing

    class << self

      def naming_map
        {
          anchor: :binding_anchor,
          nodules: :modules
        }
      end

      def division_classes
        [
          Divisions::Providers,
          Divisions::Bindings,
          Divisions::Anchor,
          Divisions::Configuration,
          Divisions::Scaling,
          Divisions::SystemPackages,
          Divisions::OtherPackages,
          Divisions::Nodules,
          Divisions::Repositories,
          Divisions::Permissions,
          Divisions::Images,
          Divisions::Packing,
          Divisions::Containers,
          Divisions::Volumes,
          Divisions::About
        ]
      end

      def associative_classes = []

      def ranking = [division_classes, associative_classes].flatten.compact

      def divisions = associative_divisions.merge(map_for(division_classes))

      def associative_divisions = map_for(associative_classes)

      def mandatory_keys = associative_divisions.keys

      def composition_class_for(key) = divisions[key]&.composition

      def map_for(classes)
        classes.inject({}) do |m, k|
          m.tap { m[key_for(k)] = k }
        end
      end

      def key_for(klass) = mapped_key_for(klass.qualifier.to_sym)

      def mapped_key_for(key) = naming_map[key] || key
    end

    delegate([:divisions, :associative_divisions, :ranking, :naming_map, :mandatory_keys] => :klass)

    def keys = divisions.keys

  end
end
