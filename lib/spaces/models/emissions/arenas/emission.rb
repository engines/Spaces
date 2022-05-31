module Arenas
  class Emission < ::Emissions::Emission

    delegate(
      arenas: :universe,
      [:perform?, :role_for, :provider_for, :compute_provider_for, :qualifier_for] => :arena,
      volume_path: :arena
    )

    relation_accessor :arena

    def arena; @arena ||= arenas.by(arena_identifier) ;end

    def arena_identifier; identifier.high ;end
    def blueprint_identifier; struct.blueprint_identifier ;end
    def application_identifier; struct.application_identifier ;end

    def images
      @images ||= duplicate(arena.images).tap { |i| i.emission = self }
    end

    def empty; super.tap { |m| m.arena = arena } ;end

    def cache_primary_identifiers
      struct.identifier = "#{arena.identifier.with_identifier_separator}#{application_identifier}"
      struct.arena_identifier = arena.identifier
    end

  end
end
