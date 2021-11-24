module Blueprinting
  module Relations # is this needed anymore?

    def relations
      OpenStruct.new(
        blueprints: relations_to_blueprints,
        arenas: relations_to_arenas
      )
    end

    def relations_to_blueprints
      OpenStruct.new(
        parents: parent_identifiers,
        descendants: descendant_identifiers,
        bindings: deep_bindings.map(&:struct), # NOW WHAT?
        embeds: embed_bindings.map(&:struct) # NOW WHAT?
      )
    end

    def relations_to_arenas
      OpenStruct.new(
        bindings: direct_arenas.map(&:identifier), # NOW WHAT?
        conscriptions: indirect_arenas.map(&:identifier)
      )
    end

    def parent_identifiers
      @parent_identifiers ||= all_identifiers_up_in(blueprints.all)
    end

    def descendant_identifiers
      @descendant_identifiers ||= deep_bindings.map(&:target_identifier).uniq # NOW WHAT?
    end

  end
end
