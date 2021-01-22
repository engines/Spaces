require_relative 'subdivision'

module Emissions
  class TargetingSubdivision < Subdivision

    delegate(
      [:blueprints, :publications] => :universe
    )

    def blueprint
      @blueprint ||=
        if blueprints.exist?(target)
          blueprints.by(target.identifier)
        else
          publications.import(target)
        end
    end

    def target; @target ||= descriptor_class.new(struct.target) ;end
    def identifier; struct.identifier || target.identifier ;end

  end
end
