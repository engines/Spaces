module Blueprinting
  module Resolving

    def resolution_in(arena)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = arena.struct.
          without(arena_specific_divisions).
          merge(struct)
        m.cache_primary_identifiers
      end.with_embeds.infixes_resolved
    end

    def arena_specific_divisions
      [:bindings, :connections, :input]
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
