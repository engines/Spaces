require_relative '../blueprints/collaboration'

module Installations
  class Collaboration < ::Blueprints::Collaboration

    delegate([:product_collaborators, :installation_divisions, :mutable_divisions] => :schema)

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def necessary_keys
      product_collaborators.keys + installation_divisions.keys
    end

  end
end
