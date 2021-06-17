module Blueprinting
  module Resolving

    def resolution_in(arena)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = arena.struct.without(:bindings).merge(struct.without(:input))
        m.cache_primary_identifiers(arena.identifier, identifier)
      end.flattened.resolved
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
