module Arenas
  module Settling

    def present_in(space) = deep_bindings_in(space, :select)
    def absent_in(space) = deep_bindings_in(space, :reject)

    def deep_bindings_in(space, method)
      all_connect_bindings.send(method) do |b|
        space.exist?(b.context_identifier)
      end
    end

    def unsaved(bound_key)
      bound_of(bound_key.singularize).reject do |s|
        space_named(bound_key).exist?(s)
      end
    end

    def bound_of(key) = bound_map_for(key).values

    def bound_map_for(key)
      bound_map[key] ||= all_connect_bindings.inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.send(key)
        end
      end.compact
    end

    def bound_map
      @bound_map ||= {}
    end

  end
end
