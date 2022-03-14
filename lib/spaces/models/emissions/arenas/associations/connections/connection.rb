require 'resolv'

module Associations
  class Connection < ::Targeting::Node

    delegate(arenas: :universe)

    def arena; @arena ||= target_from(arenas) ;end

    alias_method :node, :arena

    def context_identifier; identifier ;end
    def target_identifier; identifier ;end

    def circular_in?(identifiers)
      identifiers.include?(target_identifier)
    end

  end
end
