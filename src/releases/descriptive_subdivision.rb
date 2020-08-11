require_relative 'subdivision'

module Releases
  class DescriptiveSubdivision < Subdivision

    def resolution
      @resolution ||= universe.resolutions.by(descriptor)
    rescue Errno::ENOENT => e
      universe.blueprints.by(descriptor).resolution
    end

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

  end
end
