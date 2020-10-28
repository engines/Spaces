require_relative 'subdivision'

module Emissions
  class DescriptiveSubdivision < Subdivision

    def resolution
      @resolution ||= universe.resolutions.by(identifier)
    end

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

  end
end
