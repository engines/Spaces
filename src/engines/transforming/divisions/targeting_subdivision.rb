require_relative 'subdivision'

module Divisions
  class TargetingSubdivision < Subdivision

    class << self
      def prototype(type:, struct:, division:)
        new(struct: struct, division: division)
      end
    end

    delegate(
      [:blueprints, :publications, :resolutions] => :universe
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
        struct.target || {identifier: target_identifier}
      )
    end

    def resolution
      @resolution ||= resolution_in(emission.arena)
    end

    def resolution_in(arena)
      t = resolution_target_for(arena)
      resolutions.by(t.identifier) if resolutions.exist?(t)
    end

    def resolution_target_for(arena)
      descriptor_class.new(identifier: "#{arena.identifier}/#{target_identifier}")
    end

  end
end
