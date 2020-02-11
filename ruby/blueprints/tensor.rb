require_relative '../spaces/tensor'
require_relative '../environments/environment'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../packages/packages'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative 'dependencies/dependencies'

module Blueprints
  class Tensor < ::Spaces::Tensor

    relation_accessor :docker_file,
      :image_subject,
      :framework,
      :os_packages,
      :nodules,
      :packages,
      :dependencies,
      :environment,
      :domain

    def image_subject
      @image_subject ||= image_subject_class.new(self)
    end

    def docker_file
      @docker_file ||= docker_file_class.new(self)
    end

    def framework
      @framework ||= universe.frameworks.by(self)
    end

    def nodules
      @nodules ||= nodules_class.new(self)
    end

    def packages
      @packages ||= packages_class.new(self)
    end

    def os_packages
      @os_packages ||= os_packages_class.new(self)
    end

    def dependencies
      @dependencies ||= dependencies_class.new(struct.dependencies, self)
    end

    def environment
      @environment ||= environment_class.new(struct.environment).tap do |m|
        m.struct&.locale = OpenStruct.new.tap do |s|
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
      Docker::Files::File
    end

    def nodules_class
      Nodules::Nodules
    end

    def image_subject_class
      Images::Subject
    end

    def packages_class
      Packages::Packages
    end

    def os_packages_class
      OsPackages::OsPackages
    end

    def dependencies_class
      Dependencies
    end

    def environment_class
      Environments::Environment
    end

  end
end
