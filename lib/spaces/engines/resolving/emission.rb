module Resolving
  class Emission < ::Arenas::Emission

    delegate(
      resolutions: :universe,
      [:arena, :configuration, :connect_bindings] => :resolution
    )

    def predecessor; @predecessor ||= resolutions.by(identifier) ;end

    alias_accessor :resolution, :predecessor

    def keys; composition.keys ;end

    def cache_primary_identifiers
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
