require_relative '../spaces/tensor'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../frameworks/framework'
require_relative '../environments/environment'
require_relative '../packages/packages'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative 'dependencies/dependencies'

module Blueprints
  class Tensor < ::Spaces::Tensor

    class << self
      def inputs
        @@inputs ||= {
          framework: Frameworks::Framework,
          os_packages: OsPackages::OsPackages,
          nodules: [Nodules::Nodules, :modules],
          packages: Packages::Packages,
          dependencies: Dependencies,
          environment: Environments::Environment
        }
      end

      def outputs
        @@outputs ||= {
          docker_file: Docker::Files::File,
          image_subject: Images::Subject
        }
      end

      def internal_collaborators
        @@internal_collaborators ||= {
          domain: Domains::Domain
        }
      end

      def all_collaborators
        @@all_collaborators ||= inputs.merge(outputs).merge(internal_collaborators)
      end
    end

    def text_file_names
      blueprint.text_file_names
    end

    def all_collaborators
      self.class.all_collaborators
    end

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        v = [all_collaborators[k]].flatten
        m[k] = v.first.prototype(self) if collaborator_blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_blueprinted?(key)
      v = [all_collaborators[key]].flatten
      struct[v[1] || key]
    end

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def keys
      all_collaborators.keys
    end

    def necessary_keys
      self.class.outputs.keys + self.class.internal_collaborators.keys
    end

    def method_missing(m, *args, &block)
      if keys.include?(m)
        collaborators[m.to_sym]
      else
        super
      end
    end

  end
end
