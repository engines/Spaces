module Arenas
  module Resolving

    def bound_resolutions; bound_map.values ;end

    def bound_map
      @bound_map ||= resolvable_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolved_in(self)
        end
      end.compact
    end

    alias_method :resolution_map, :bound_map

    def resolvable_blueprints
      connected_blueprints.map do |b|
        b.binder? ? b.connected_blueprints.flatten.map(&:blueprint) : b
      end.flatten
    end

  end
end
