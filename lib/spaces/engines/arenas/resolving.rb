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

    def bootstrap_blueprints
      connect_targets.map(&:blueprint).map(&:connect_targets).flatten.map(&:blueprint)
    end

  end
end
