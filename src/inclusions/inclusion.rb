require_relative '../releases/subdivision'

module Inclusions
  class Inclusion < ::Releases::Subdivision

    # def resolution
    #   @resolution ||= universe.resolutions.by(descriptor)
    # rescue Errno::ENOENT => e
    #   universe.blueprints.by(descriptor).resolution
    # end
    #
    # def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    # def identifier; struct.identifier || descriptor.identifier ;end

  end
end
