module Targeting
  class TreeSpace < ::Spaces::Space

    def new_leaves_for(identifier:)
      identifiers - existing_nodes_for(identifier: identifier)
    end

    def existing_nodes_for(identifier:)
      [
        (i = identifier.identifier),
        unrepeatable_children_for(identifier),
        descendant_path_identifiers.select { |x| x.include?(i) }.map { |a| a.split(i).first }
      ].flatten.uniq
    end

    def unrepeatable_children_for(identifiable); [] ;end

    def descendant_path_identifiers
      all.map(&:descendant_paths).flatten.map(&:identifiers)
    end

  end
end
