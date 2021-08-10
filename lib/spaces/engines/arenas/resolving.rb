require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def resolved; present_in(resolutions) ;end
    def unresolved; absent_in(resolutions) ;end

    def unsaved_resolutions; unsaved(:resolution) ;end
    def bound_resolutions; resolution_map.values ;end

    def resolution_map; bound_map_for(:resolution) ;end

  end
end
