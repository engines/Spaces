module Targeting
  class TreeSpace < ::Spaces::Space

    def circular?(parent_identifier, candidate_child_identifier)
      descendant_path_identifiers.map do |x|
        [
          x.index(parent_identifier.to_s),
          x.index(candidate_child_identifier.to_s)
        ].compact
      end.any? { |x| x.count == 2 && x.first > x.last }
    end

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
