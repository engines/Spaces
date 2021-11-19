require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def bound_resolutions_deep # NOW WHAT?
      resolved.map { |b| b.resolution_in(self) }
    end

    def resolved; present_in(resolutions) ;end
    def unresolved; absent_in(resolutions) ;end

    def unsaved_resolutions; unsaved(:resolutions) ;end
    def bound_resolutions; resolution_map.values ;end # NOW WHAT?

    def resolution_map; bound_map_for(:resolution) ;end # NOW WHAT?

  end
end
