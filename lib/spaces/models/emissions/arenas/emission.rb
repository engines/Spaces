module Arenas
  class Emission < ::Emissions::Emission

    delegate(
      [:blueprints, :arenas] => :universe,
      [:perform?, :role_providers, :role_for, :provider_for, :compute_provider_for_identifier, :qualifier_for] => :arena,
      volume_path: :arena
    )

    def predecessor
      @predecessor ||= blueprints.by(blueprint_identifier)
    end

    alias_accessor :blueprint, :predecessor
    alias_accessor :binder, :predecessor

    relation_accessor :arena

    def arena
      @arena ||= arenas.by(arena_identifier)
    end

    def arena_identifier = struct.arena_identifier
    def blueprint_identifier = struct.blueprint_identifier
    def application_identifier = struct.application_identifier

    def resource_identifier =
      [arena_identifier, application_identifier].join('-').hyphenated

    def images
      @images ||= duplicate(arena.images).tap { |i| i.emission = self }
    end

    def documentation_only_keys =
      [super, arena.keys, cache_identifiers, :deployment].flatten.uniq

    def cache_identifiers =
      [:arena_identifier, :blueprint_identifier, :application_identifier]

    def empty =  super.tap { |m| m.arena = arena }

    def cache_identifiers!
      struct.arena_identifier = arena.identifier
      struct.blueprint_identifier = blueprint.identifier
      struct.application_identifier = blueprint.application_identifier
      struct.identifier = "#{arena.identifier.with_identifier_separator}#{application_identifier}"
    end

  end
end
