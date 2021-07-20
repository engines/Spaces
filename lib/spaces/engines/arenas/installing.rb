require_relative 'settling'

module Arenas
  module Installing
    include Settling

    def unsaved_installations; unsaved_settlements_of(:installation) ;end

    def bound_installations; installation_map.values ;end

    def installation_map; bound_settlement_map_for(:installation) ;end

  end
end
