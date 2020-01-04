require_relative 'tensor'

module Container
  class DockerFile < ::Spaces::Product
    # A mechanism by which software can be made executable.

    relation_accessor :tensor,
      :framework

    def initialize(tensor)
      self.tensor = tensor
    end

    def contents
      layers.flatten.compact.join("\n\n")
    end

    def layers
      [
        framework.first_layer(descriptor),
        framework.setup_layers,
        memory_layer
      ]
    end

    def memory_layer
      "ENV Memory '#{tensor.struct.version.software.memory_usage.recommended}'"
    end

    def framework
      @framework ||= universe.frameworks.by(tensor.struct.version.software.framework).tap do |m|
        m.struct = duplicate(tensor.struct.version.software.framework)
      end
    end

    def file_path
      "#{name}/DockerFile"
    end

    def subspace_path
      name
    end

    def name
      tensor.struct.version.descriptor.name
    end

    def universe
      @universal_space ||= Universal::Space.new
    end

  end
end
