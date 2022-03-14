module Associations
  class Connections < ::Divisions::Divisible

    def tree_paths(previous = OpenStruct.new(identifiers: [context_identifier]))
      [any? ? map { |b| b.tree_path_with(previous) } : previous].flatten
    end

  end
end
