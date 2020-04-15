require_relative '../spaces/model'
require_relative '../projects/specification'
require_relative 'specification'

module Installations
  class Collaboration < ::Spaces::Model
    extend Specification

    class << self

      def blueprint
        Projects::Blueprint
      end

      def blueprint_divisions
        @@blueprint_divisions ||= map_for(blueprint.division_classes)
      end

      def product_collaborators
        @@product_collaborators ||= map_for(product_classes)
      end

      def installation_divisions
        @@installation_divisions ||= map_for(installation_classes)
      end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      def all_collaborators
        @@all_collaborators ||= blueprint_divisions.merge(installation_divisions).merge(product_collaborators)
      end

      def key_for(klass)
        mapped_key_for(klass.to_s.snakize.split('/').last.to_sym)
      end

      def mapped_key_for(key)
        division_map[key] || key
      end

      def division_map
        blueprint.division_map.merge(super)
      end

      def mutable_divisions
        blueprint.mutable_divisions + super
      end
    end

    delegate(
      [
        :all_collaborators,
        :product_collaborators,
        :installation_divisions,
        :mutable_divisions
      ] => :klass
    )

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
      necessary_keys.include?(key)
    end

    def keys
      all_collaborators.keys
    end

    def necessary_keys
      product_collaborators.keys + installation_divisions.keys
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
