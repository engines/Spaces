module Arenas
  module Settling

    def present_in(space); deep_in(space, :select) ;end
    def absent_in(space); deep_in(space, :reject) ;end

    def deep_in(space, method)
      deep_connect_bindings.send(method) do |b|
        space.exist?(b.settlement_identifier_in(self))
      end
    end

    def unsaved(bound_key)
      bound_of(bound_key.singularize).reject do |s|
        space_named(bound_key).exist?(s)
      end
    end

    def bound_of(key)
      bound_map_for(key).values
    end

    def bound_map_for(key)
      bound_map[key] ||= connectable_blueprints.inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.send("#{key}_in", self)
        end
      end.compact
    end

    def bound_map; @bound_map ||= {} ;end

  end
end
