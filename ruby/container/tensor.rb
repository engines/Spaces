require_relative '../spaces/tensor'
require_relative 'container'
require_relative 'docker/file'
require_relative 'dependencies/dependencies'

module Container
  class Tensor < ::Spaces::Tensor

    relation_accessor :docker_file,
      :framework,
      :dependencies,
      :environment,
      :domain

    def docker_file
      @docker_file ||= docker_file_class.new(self)
    end

    def framework
      if (f = struct.software.framework)
        @framework ||=
          universe.frameworks.by(f).tap do |m|
            m.struct = duplicate(f)
          end
      end
    end

    def dependencies
      @dependencies ||= dependencies_class.new(struct.dependencies, self)
    end

    def environment
      @environment ||= universe.environments.by('')
    end

    def domain
      #@domain ||= universe.domains.by('')
      @domain ||= universe.domains.model_class.new(struct.descriptor)
    end

    def docker_file_class
      Docker::File
    end

    def dependencies_class
      Dependencies
    end

  end
end
