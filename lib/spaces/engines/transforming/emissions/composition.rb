module Emissions
  class Composition < ::Spaces::Thing

    class << self

      def naming_map
        {
          target: :binding_target
        }
      end

      def division_classes
        [
          Divisions::Configuration,
          Divisions::Bindings,
          Divisions::Target,
          Divisions::ServiceTasks,
          Divisions::Scaling,
          Divisions::SystemPackages,
          Divisions::OtherPackages,
          Divisions::Modules,
          Divisions::Repositories,
          Divisions::Permissions,
          Divisions::Images,
          Divisions::Volumes,
          Divisions::Ports,
          Divisions::About
        ]
      end

      def associative_classes; [] ;end

      def ranking; [division_classes, associative_classes].flatten.compact ;end

      def divisions
        map_for(division_classes)
      end

      def associations
        map_for(associative_classes)
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

    delegate([:divisions, :associations, :ranking, :naming_map] => :klass)

    def keys; @keys ||= associations.keys + divisions.keys ;end

    def associations_and_divisions; associations.merge(divisions) ;end

  end
end
