module Arenas
  module Settling

    def unsaved_settlements_of(type)
      bound_settlements_of(type).reject do |s|
        space_for(type).exist?(s)
      end
    end

    def bound_settlements_of(type)
      bound_settlement_map_for(type).values
    end

    def bound_settlement_map_for(type)
      bound_map[type] ||= connectable_blueprints.map(&:with_embeds).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.send("#{type}_in", self)
        end
      end.compact
    end

    def bound_map; @bound_map ||= {} ;end

    def space_for(type); send("#{type}".pluralize) ;end

  end
end
