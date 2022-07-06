module Arenas
  module Relations

    def relations =
      OpenStruct.new(arenas: relations_to_arenas)

    def relations_to_arenas =
      OpenStruct.new(
        parents: parent_identifiers,
        descendants: descendant_identifiers
      )

    def parent_identifiers
      @parent_identifiers ||= all_identifiers_up_in(arenas.all)
    end

    def descendant_identifiers
      @descendant_identifiers ||= (deep_arenas - [self]).map(&:identifier).uniq
    end

  end
end
