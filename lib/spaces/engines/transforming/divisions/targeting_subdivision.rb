require_relative 'subdivision'

module Divisions
  class TargetingSubdivision < Subdivision

    class << self
      def prototype(type:, struct:, division:)
        new(struct: struct, division: division)
      end
    end

    delegate(
      [:locations, :blueprints, :installations, :resolutions] => :universe
    )

    def blueprint
      @blueprint ||=
      if blueprints.exist?(descriptor)
        blueprints.by(descriptor.identifier)
      else
        blueprints.by_demand(descriptor)
      end
    end

    def identifier; struct.identifier || target_identifier ;end
    def target_identifier; struct.target_identifier || descriptor&.identifier ;end

    def descriptor
      @descriptor ||= descriptor_class.new(
        struct.target || {identifier: struct.target_identifier}
      )
    end

    def installation; @installation ||= settlement_in(arena, installations) ;end
    def resolution; @resolution ||= settlement_in(arena, resolutions) ;end

    def settlement_in(arena, space)
      space.exist_then(arena) { space.by(settlement_target_in(arena)) }
    end

    def settlement_identifier
      settlement_identifier_in(arena)
    end
    alias_method :resolution_identifier, :settlement_identifier

    def settlement_target_in(arena)
      descriptor_class.new(identifier: settlement_identifier_in(arena))
    end

    def settlement_identifier_in(arena)
      "#{arena.identifier.with_identifier_separator}#{target_identifier}"
    end

  end
end
