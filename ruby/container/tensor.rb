require_relative '../spaces/tensor'
require_relative 'container'
require_relative 'docker_file'

module Container
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :docker_file,
      :dependencies

    def docker_file
      @docker_file ||= DockerFile.new(self)
    end

    def dependencies
      @dependencies ||= dependency_descriptors.map do |d|
        universe.blueprints.by(d)&.container_tensor
      end.compact
    end

    def dependency_descriptors
      struct.dependencies&.map { |d|
        descriptor_class.new(d.descriptor)
      } || []
    end
  end
end
