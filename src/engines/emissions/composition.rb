module Emissions
  class Composition < ::Spaces::Thing

    class << self

      def naming_map
        {
          target: :binding_target,
          nodules: :modules
        }
      end

      def division_classes
        [
          Divisions::Providers,
          Divisions::Bindings,
          Divisions::Target,
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

      def associative_classes; [] ;end

      def ranking; [division_classes, associative_classes].flatten.compact ;end

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

    delegate([:divisions, :associative_divisions, :ranking, :naming_map, :mandatory_keys] => :klass)

    def keys
      divisions.keys
    end

  end
end
