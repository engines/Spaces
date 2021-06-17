module Settling
  class Settlement < ::Emissions::Emission

    delegate(
      resolutions: :universe,
      [:arenas, :blueprints] => :resolutions
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

    def connections_settled(&block)
      connections_down(emission: :blueprint).map { |c| block.call(c) }
    end

    def empty; super.tap { |m| m.arena = arena } ;end

  end
end
