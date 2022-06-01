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

    def cache_primary_identifiers!
      struct.arena_identifier = resolution.arena_identifier
      struct.identifier = resolution.identifier
      struct.application_identifier = resolution.application_identifier
      struct.blueprint_identifier = resolution.blueprint_identifier
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
