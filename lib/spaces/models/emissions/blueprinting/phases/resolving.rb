module Blueprinting
  module Resolving

    def resolution_in(arena, binding)
      empty_resolution.tap do |m|
        m.arena = arena
        m.struct = arena.struct.
          without(arena_specific_divisions).
          merge(struct)
        m.struct.blueprint_identifier = binding.target_identifier
        m.struct.application_identifier = binding.application_identifier
        m.cache_primary_identifiers
      end.with_embeds.with_injection(binding).infixes_resolved
    end

    def arena_specific_divisions
      [:bindings, :connections, :input]
    end

    def empty_resolution; resolution_class.new ;end
    def resolution_class; ::Resolving::Resolution ;end

  end
end
