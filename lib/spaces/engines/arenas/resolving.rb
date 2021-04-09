module Arenas
  module Resolving

    def resolutions; resolution_map.values ;end

    def resolution_map
      @resolution_map ||= bootstrap_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolved_in(self)
        end
      end.compact
    end

    def clear_resolution_map; @resolution_map = nil ;end

    def bootstrap_blueprints
      bootstrap_targets.flatten.map(&:blueprint)
    end

    def bootstrap_targets
      bootstraps.map(&:connect_targets)
    end

    def bootstraps
      connect_targets.map(&:blueprint)
    end

  end
end
