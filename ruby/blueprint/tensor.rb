require_relative '../spaces/tensor'
require_relative '../environment/environment'
require_relative '../docker/file/file'
require_relative 'dependencies/dependencies'

module Blueprint
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
      if (f = struct.framework)
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
      @environment ||= environment_class.new(struct.environment).tap do |m|
        m.struct.locale = OpenStruct.new.tap do |s|
          s.language = 'en_AU:en'
          s.lang = 'en_AU.UTF8'
          s.lc_all = 'en_AU.UTF8'
        end
      end
    end

    def domain
      #@domain ||= universe.domains.by('')
      @domain ||= universe.domains.model_class.new(struct)
    end

    def docker_file_class
      Docker::File
    end

    def dependencies_class
      Dependencies
    end

    def environment_class
      Environment::Environment
    end

  end
end
