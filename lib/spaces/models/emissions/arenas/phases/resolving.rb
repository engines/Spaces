require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def resolved = bindings_with_resolutions

    def bindings_with_resolutions = present_in(resolutions)
    def bindings_without_resolutions = absent_in(resolutions)

    def unsaved_resolutions = unsaved(:resolutions)
    def bound_resolutions = resolution_map.values

    def directly_bound_resolutions =
      bound_resolutions.select { |r| r.arena_identifier == identifier}

    def resolution_map = bound_map_for(:resolution)

  end
end
