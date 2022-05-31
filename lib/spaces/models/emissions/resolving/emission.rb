module Resolving
  class Emission < ::Arenas::Emission

    class << self
      def composition_class; ::Emissions::NoComposition ;end
    end

    delegate(
      resolutions: :universe,
      important_division_for: :resolution
    )

    def provider
      provider_for(:runtime)
    end

    def predecessor
      @predecessor ||= resolutions.exist_then_by(identifier)
    end

    alias_accessor :resolution, :predecessor

    def cache_primary_identifiers
      struct.arena_identifier = arena.identifier
      struct.application_identifier = application_identifier
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
