module Blueprinting
  module Relations

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
        bindings: deep_bindings.map(&:struct),
        embeds: embed_bindings.map(&:struct)
      )
    end

    def relations_to_arenas
      OpenStruct.new(
        direct: direct_arenas.map(&:identifier),
        indirect: indirect_arenas.map(&:identifier)
      )
    end

    def parent_identifiers
      @parent_identifiers ||= all_identifiers_up_in(blueprints.all)
    end

    def descendant_identifiers
      @descendant_identifiers ||= deep_bindings.map(&:target_identifier).uniq
    end

  end
end
