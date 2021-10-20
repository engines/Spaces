module Blueprinting
  module Resolving

    def resolution_in(arena)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = arena.struct.without(:bindings, :configuration).merge(struct.without(:input))
        m.cache_primary_identifiers
      end.with_embeds.infixes_resolved
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
