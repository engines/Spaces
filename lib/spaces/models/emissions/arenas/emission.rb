module Arenas
  class Emission < ::Emissions::Emission

    delegate(
      arenas: :universe,
      images: :arena,
      provider_for: :arena,
      [:runtime_qualifier, :orchestration_qualifier, :packtime_qualifier] => :arena,
      volume_path: :arena
    )

    relation_accessor :arena

    def arena; @arena ||= arenas.by(arena_identifier) ;end

    def arena_identifier; identifier.high ;end

    def empty; super.tap { |m| m.arena = arena } ;end

    def cache_primary_identifiers
      struct.identifier = "#{arena.identifier.with_identifier_separator}#{blueprint_identifier}"
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint_identifier
    end

  end
end
