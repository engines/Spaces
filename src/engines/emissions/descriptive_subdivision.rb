require_relative 'subdivision'

module Emissions
  class DescriptiveSubdivision < Subdivision

    def resolution
      @resolution ||= universe.resolutions.by(descriptor.identifier)
    end

    def blueprint
      @blueprint ||= universe.blueprints.by(descriptor.identifier)
    end

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

  end
end
