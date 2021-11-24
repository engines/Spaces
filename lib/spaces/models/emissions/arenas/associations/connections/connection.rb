require 'resolv'

module Associations
  class Connection < ::Targeting::Subdivision

    delegate(arenas: :universe)

    def arena; @arena ||= emission_from(arenas) ;end

    def context_identifier; identifier ;end

  end
end
