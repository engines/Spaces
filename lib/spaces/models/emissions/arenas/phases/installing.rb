require_relative 'settling'

module Arenas
  module Installing
    include Settling

    def installed; present_in(installations) ;end
    def uninstalled; absent_in(installations) ;end

    def installation_map; bound_map_for(:installation) ;end

  end
end
