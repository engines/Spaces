module Arenas
  module Settling

    def present_in(space); deep_bindings_in(space, :select) ;end
    def absent_in(space); deep_bindings_in(space, :reject) ;end

    def deep_bindings_in(space, method) # NOW WHAT?
      deep_connect_bindings.send(method) do |b|
        space.exist?(b.context_identifier)
      end
    end

    def unsaved(bound_key) # NOW WHAT?
      bound_of(bound_key.singularize).reject do |s|
        space_named(bound_key).exist?(s)
      end
    end

    def bound_of(key) # NOW WHAT?
      bound_map_for(key).values
    end

    def bound_map_for(key) # NOW WHAT?
      bound_map[key] ||= connectable_blueprints.inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.send("#{key}_in", self)
        end
      end.compact
    end

    def bound_map; @bound_map ||= {} ;end # NOW WHAT?

  end
end
