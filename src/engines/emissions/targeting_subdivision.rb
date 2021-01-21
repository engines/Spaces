require_relative 'subdivision'

module Emissions
  class TargetingSubdivision < Subdivision

    def resolution
      @resolution ||= universe.resolutions.by(target.identifier)
    end

    def blueprint
      @blueprint ||= universe.blueprints.by(target.identifier)
    end

    def target; @target ||= descriptor_class.new(struct.target) ;end
    def identifier; struct.identifier || target.identifier ;end

  end
end
