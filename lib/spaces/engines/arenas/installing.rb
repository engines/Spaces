require_relative 'settling'

module Arenas
  module Installing
    include Settling

    def uninstalled
      deep_connect_bindings.reject do |b|
        installations.exist?(b.settlement_identifier_in(self))
      end
    end

    def unsaved_installations; unsaved_of(:installation) ;end

    def bound_installations; installation_map.values ;end

    def installation_map; bound_map_for(:installation) ;end

  end
end
