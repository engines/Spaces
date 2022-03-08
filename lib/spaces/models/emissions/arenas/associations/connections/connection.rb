require 'resolv'

module Associations
  class Connection < ::Targeting::Subdivision

    delegate(arenas: :universe)

    def arena; @arena ||= target_from(arenas) ;end

    def context_identifier; identifier ;end
    def target_identifier; identifier ;end

  end
end
