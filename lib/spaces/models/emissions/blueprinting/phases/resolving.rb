module Blueprinting
  module Resolving

    def resolution_in(arena, binding)
      with_cache!(binding).empty_resolution.tap do |m|
        m.arena = arena
        m.predecessor = self
        m.struct = arena.struct.
          without(arena_specific_divisions).
          merge(struct)
        m.cache_identifiers!
      end.with_embeds.with_injection(binding).infixes_resolved
    end

    def with_cache!(binding)
      tap { cache_identifiers!(binding) }
    end

    def arena_specific_divisions = [:bindings, :connections, :input]

    def empty_resolution = resolution_class.new
    def resolution_class = ::Resolving::Resolution

  end
end
