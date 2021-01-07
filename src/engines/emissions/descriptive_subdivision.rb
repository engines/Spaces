require_relative 'subdivision'

module Emissions
  class DescriptiveSubdivision < Subdivision

    def resolution = @resolution ||= universe.resolutions.by(identifier)

    def blueprint = @blueprint ||= universe.blueprints.import(descriptor)

    def descriptor = @descriptor ||= descriptor_class.new(struct.descriptor)
    def identifier = struct.identifier || descriptor.identifier

  end
end
