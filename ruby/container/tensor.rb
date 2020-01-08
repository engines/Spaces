require_relative '../spaces/tensor'
require_relative 'container'
require_relative 'docker_file'

module Container
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :docker_file

    def docker_file
      @docker_file ||= DockerFile.new(self)
    end

    def name
      struct.version.descriptor.name
    end

  end
end
