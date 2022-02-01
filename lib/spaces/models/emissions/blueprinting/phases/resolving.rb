module Blueprinting
  module Resolving

    def resolution_in(arena)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = struct
        m.cache_primary_identifiers
      end.with_embeds.infixes_resolved
    end

    def irrelevant_arena_divisions
      [:bindings, :connections, :input, :configuration]
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
