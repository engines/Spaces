require_relative 'subdivision'

module Emissions
  class TargetingSubdivision < Subdivision

    delegate(
      [:blueprints, :publications, :resolutions] => :universe
    )

    def blueprint
      @blueprint ||=
        if blueprints.exist?(blueprint_target)
          blueprints.by(blueprint_target.identifier)
        else
          publications.by_import(blueprint_target)
        end
    end

    def blueprint_target; @blueprint_target ||= descriptor_class.new(struct.target) ;end
    def identifier; struct.identifier || root_identifier ;end
    def root_identifier; blueprint_target.identifier ;end

    def resolution_in(arena)
      t = resolution_target_for(arena)
      resolutions.by(t.identifier) if resolutions.exist?(t)
    end

    def resolution_target_for(arena)
      descriptor_class.new(identifier: "#{arena.identifier}/#{identifier}")
    end

  end
end
