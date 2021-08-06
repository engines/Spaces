require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def unresolved
      deep_connect_bindings.reject do |b|
        resolutions.exist?(b.settlement_identifier_in(self))
      end
    end

    def unsaved_resolutions; unsaved_settlements_of(:resolution) ;end

    def bound_resolutions; resolution_map.values ;end

    def resolution_map; bound_map_for(:resolution) ;end

  end
end
