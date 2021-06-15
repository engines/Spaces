module Arenas
  module Resolving

    def bound_resolutions; bound_resolution_map.values ;end

    def bound_resolution_map
      @bound_resolution_map ||= connectable_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolved_in(self)
        end
      end.compact
    end

    alias_method :resolution_map, :bound_resolution_map

  end
end
