module Arenas
  module BootstrapResolving

    def bootstrap_resolutions; bootstrap_map.values ;end

    def bootstrap_map
      @bootstrap_map ||= bootstrap_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolved_in(self)
        end
      end.compact
    end

    def bootstrap_blueprints
      bootstrap_bindings.flatten.map(&:blueprint)
    end

    def bootstrap_bindings
      bootstraps.map(&:connect_bindings)
    end

    def bootstraps
      connect_bindings.map(&:blueprint)
    end

  end
end
