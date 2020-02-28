require 'duplicate'
require_relative '../spaces/model'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../frameworks/framework'
require_relative '../environments/environment'
require_relative '../packages/packages'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative 'dependencies/dependencies'
require_relative 'identifiers'

module Blueprints
  class Tensor < ::Spaces::Model

    class << self
      def blueprint_collaborators
        @@blueprint_collaborators ||= {
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

      def installation_collaborators
        @@installation_collaborators ||= {
          identifiers: Identifiers,
          domain: Domains::Domain
        }
      end

      def all_collaborators
        @@all_collaborators ||= blueprint_collaborators.merge(outputs).merge(installation_collaborators)
      end
    end

    relation_accessor :blueprint

    def text_file_names
      blueprint.text_file_names
    end

    def all_collaborators
      self.class.all_collaborators
    end

    def outputs
      self.class.outputs
    end

    def installation_collaborators
      self.class.installation_collaborators
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
      outputs.keys + installation_collaborators.keys
    end

    def initialize(blueprint)
      self.blueprint = blueprint
      self.struct = duplicate(blueprint.struct)
      installation_collaborators.keys.each { |k| self.struct[k] = collaborators[k].struct }
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
