require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def bindings_with_resolutions; present_in(resolutions) ;end
    def bindings_without_resolutions; absent_in(resolutions) ;end

    def unsaved_resolutions; unsaved(:resolutions) ;end
    def bound_resolutions; resolution_map.values ;end

    def directly_bound_resolutions
      bound_resolutions.select { |r| r.arena_identifier == identifier}
    end

    def resolution_map; bound_map_for(:resolution) ;end

  end
end
