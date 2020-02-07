require_relative '../spaces/tensor'
require_relative '../environment/environment'
require_relative '../docker/file'
require_relative '../image/subject'
require_relative '../package/packages'
require_relative '../os_package/os_packages'
require_relative '../nodule/nodules'
require_relative 'dependency/dependencies'

module Blueprint
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
      if (f = struct.framework)
        @framework ||=
          universe.frameworks.by(f).tap do |m|
            m.struct = duplicate(f)
          end
      end
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

    def nodules_class
      Nodule::Nodules
    end

    def image_subject_class
      Image::Subject
    end

    def packages_class
      Package::Packages
    end

    def os_packages_class
      OsPackage::OsPackages
    end

    def dependencies_class
      Dependencies
    end

    def environment_class
      Environment::Environment
    end

  end
end
