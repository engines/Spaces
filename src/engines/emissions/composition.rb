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
          Divisions::Nodules,
          Divisions::OtherPackages,
          Divisions::Repositories,
          Divisions::Images,
          Divisions::Packing,
          Divisions::Containers,
          Divisions::Volumes
        ]
      end

      def associative_classes; [] ;end

      def divisions
        associative_divisions.merge(map_for(division_classes))
      end

      def associative_divisions
        map_for(associative_classes)
      end

      def mandatory_keys
        associative_divisions.keys
      end

      def composition_class_for(key)
         divisions[key]&.composition
      end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m.tap { m[key_for(k)] = k }
        end
      end

      def key_for(klass)
        mapped_key_for(klass.qualifier.to_sym)
      end

      def mapped_key_for(key)
         naming_map[key] || key
      end
    end

    delegate([:divisions, :associative_divisions, :naming_map, :mandatory_keys] => :klass)

    def keys
      divisions.keys
    end

  end
end
