require_relative '../spaces/model'
require_relative 'schema'

module Projects
  class ActiveSchema < ::Spaces::Model
    extend Schema

    class << self
      def blueprint_divisions
        @@blueprint_divisions ||= map_for(division_classes)
      end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      def all_collaborators
        @@all_project_collaborators ||= blueprint_divisions
      end

      def key_for(klass)
        mapped_key_for(klass.to_s.snakize.split('/').last.to_sym)
      end

      def mapped_key_for(key)
        division_map[key] || key
      end
    end

    delegate([:all_collaborators, :mutable_divisions] => :klass)

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = collaborator_for(k) if blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_for(key)
      all_collaborators[key].prototype(installation: self, blueprint_label: key)
    end

    def blueprinted?(key)
      struct[key]
    end

    def collaborate_anyway?(key)
      false
    end

    def keys
      all_collaborators.keys
    end

    def method_missing(m, *args, &block)
      if keys.include?(m)
        collaborators[m.to_sym]
      else
        super
      end
    end

  end
end
