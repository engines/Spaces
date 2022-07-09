require 'resolv'

module Associations
  class Connection < ::Targeting::Node

    delegate(arenas: :universe)

    def arena
      @arena ||= target_from(arenas)
    end

    alias_method :node, :arena

    def context_identifier = identifier
    def target_identifier = identifier

  end
end
