require_relative '../spaces/tensor'
require_relative 'container'
require_relative 'docker_file'
require_relative 'need'

module Container
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :docker_file,
      :dependencies,
      :framework,
      :needs,
      :environment,
      :domain

    def docker_file
      @docker_file ||= docker_file_class.new(self)
    end

    def dependencies
      @dependencies ||= dependency_descriptors.map do |d|
        universe.blueprints.by(d)&.container_tensor
      end.compact
    end

    def dependency_descriptors
      struct.dependencies&.map { |d| descriptor_class.new(d.descriptor) } || []
    end

    def framework
      if (f = struct.software.framework)
        @framework ||=
          universe.frameworks.by(f).tap do |m|
            m.struct = duplicate(f)
          end
      end
    end

    def resolution_for(h)
      overrides(struct.dependents&.variables).merge(h)
    end

    def overrides(struct = OpenStruct.new)
      h = struct.to_h
      h.keys.inject({}) do |m, k|
        m[k] =
          begin
            send(h[k])
          rescue TypeError, NoMethodError
            h[k]
          end
        m
      end
    end

    def needs
      @needs ||= struct.dependencies&.map { |d| need_class.new(d, self) } || []
    end

    def environment
      @environment ||= universe.environments.by('')
    end

    def domain
      #@domain ||= universe.domains.by('')
      @domain ||= universe.domains.model_class.new(struct.descriptor)
    end

    def host
      "#{descriptor.identifier}.spaces.internal"
    end

    def name
      descriptor.identifier
    end

    def username
      descriptor.identifier
    end

    def password
      @password ||= SecureRandom.hex(10)
    end


    def docker_file_class
      DockerFile
    end

    def need_class
      Need
    end

  end
end
