require_relative 'settling'

module Arenas
  module Resolving
    include Settling

    def bound_resolutions_deep # NOW WHAT?
      resolved_bindings_with_self_deep.map(&:resolution)
    end

    def resolved_bindings_with_self_deep
      bindings_with_resolutions.map do |b|
        binding_class.new(b, self)
      end
    end

    def bindings_with_resolutions; present_in(resolutions) ;end
    def bindings_without_resolutions; absent_in(resolutions) ;end

    def unsaved_resolutions; unsaved(:resolutions) ;end
    def bound_resolutions; resolution_map.values ;end # NOW WHAT?

    def resolution_map; bound_map_for(:resolution) ;end # NOW WHAT?

  end
end
