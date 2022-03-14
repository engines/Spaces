require 'resolv'

module Associations
  class Connection < ::Targeting::Subdivision

    delegate(arenas: :universe)

    def arena; @arena ||= target_from(arenas) ;end

    def context_identifier; identifier ;end
    def target_identifier; identifier ;end

    def tree_path_with(previous)
      unless circular_in?(p = previous.identifiers)
        arena.tree_paths(OpenStruct.new(identifiers: [p, target_identifier].flatten))
      else
        previous
      end
    end

    def circular_in?(identifiers)
      identifiers.include?(target_identifier)
    end

  end
end
