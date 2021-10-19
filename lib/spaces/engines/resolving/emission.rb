module Resolving
  class Emission < ::Arenas::Emission

    delegate(
      resolutions: :universe,
      mandatory_division_for: :resolution
    )

    def predecessor; @predecessor ||= resolutions.by(identifier) ;end

    alias_accessor :resolution, :predecessor

    def cache_primary_identifiers
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

    def method_missing(m, *args, &block)
      return resolution.send(m, *args, &block) if resolution.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      resolution.respond_to?(m) || super
    end

  end
end
