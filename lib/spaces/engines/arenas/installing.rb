require_relative 'settling'

module Arenas
  module Installing
    include Settling

    def installed; present_in(installations) ;end
    def uninstalled; absent_in(installations) ;end

    def unsaved_installations; unsaved(:installation) ;end
    def bound_installations; installation_map.values ;end

    def installation_map; bound_map_for(:installation) ;end

  end
end
