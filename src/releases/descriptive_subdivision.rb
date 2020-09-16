require_relative 'subdivision'

module Releases
  class DescriptiveSubdivision < Subdivision

    def resolution
      @resolution ||= universe.resolutions.by(descriptor)
    end

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

  end
end
