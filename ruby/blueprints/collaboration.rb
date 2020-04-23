require_relative '../spaces/model'
require_relative 'schema'

module Blueprints
  class Collaboration < ::Spaces::Model
    extend ::Blueprints::Schema

    delegate([:outline, :collaborator_map, :keys] => :schema)

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = collaborator_for(k) if blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_for(key)
      collaborator_map[key].prototype(installation: self, blueprint_label: key)
    end

    def blueprinted?(key)
      struct[key]
    end

    def collaborate_anyway?(key)
      false
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
