require_relative '../blueprints/collaboration'

module Installations
  class Collaboration < ::Blueprints::Collaboration

    delegate([:associative_divisions, :component_class_map] => :schema)

    def collaborator_map
      @installation_collaborator_map ||= super.merge(
        schema_keys.reduce({}) do |m, k|
          m[k] = protoype_for(k)
          m
        end.compact
      )
    end

  end
end
