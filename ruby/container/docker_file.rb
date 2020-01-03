require_relative 'tensor'

module Container
  class DockerFile < ::Spaces::Product
    # A mechanism by which software can be made executable.

    relation_accessor :tensor,
      :framework

    def initialize(tensor)
      self.tensor = tensor
    end

    def instructions
    end

    def framework
      @framework ||= framework_space.by(tensor.struct.version.software.framework).tap do |m|
        m.struct = duplicate(tensor.struct.version.software.framework)
      end
    end

    def framework_space
      Universal::Space.framework
    end

  end
end
