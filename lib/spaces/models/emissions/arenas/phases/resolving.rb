require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def all_resolutions
      resolutions.identifiers(arena_identifier: identifier).map do |i|
        resolutions.by(i)
      end
    end

    def resolved; present_in(resolutions) ;end
    def unresolved; absent_in(resolutions) ;end

    def unsaved_resolutions; unsaved(:resolutions) ;end
    def bound_resolutions; resolution_map.values ;end

    def resolution_map; bound_map_for(:resolution) ;end

  end
end
