require_relative 'status'

module Installing
  class Installation < ::Emissions::Emission
    include Installing::Status

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:runtime_binding, :packing_binding] => :arena,
      [:resolutions, :packs, :provisioning] => :universe,
      [:arenas, :blueprints] => :resolutions,
      bindings_of_type: :predecessor
    )

    def arena; @arena ||= arenas.by(arena_identifier) ;end

    def predecessor; @predecessor ||= blueprints.by(blueprint_identifier) ;end

    alias_accessor :blueprint, :predecessor
    alias_accessor :binder, :predecessor

    def identifiers
      super.merge(
        {
          arena_identifier: arena_identifier,
          blueprint_identifier: blueprint_identifier
        }
      )
    end

    def arena_identifier; identifier.split_compound.first ;end

    def connections_installed
      connections_down(emission: :blueprint).map { |c| c.with_embeds.installed_in(arena) }
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
