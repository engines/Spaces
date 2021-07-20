module Resolving
  class Emission < ::Arenas::Emission

    delegate(
      resolutions: :universe,
      [:arena, :connect_bindings] => :resolution
    )

    def predecessor; @predecessor ||= resolutions.by(identifier) ;end

    alias_accessor :resolution, :predecessor

    def keys; composition.keys ;end

    def cache_primary_identifiers
      # struct.identifier = "#{arena.identifier.with_identifier_separator}#{blueprint_identifier}"
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
