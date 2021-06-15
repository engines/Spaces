module Arenas
  module Installing

    def bound_installations; bound_installation_map.values ;end

    def bound_installation_map
      @bound_installation_map ||= connectable_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.installed_in(self)
        end
      end.compact
    end

    alias_method :installation_map, :bound_installation_map

  end
end
