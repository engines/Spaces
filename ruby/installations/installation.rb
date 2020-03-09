require 'duplicate'
require_relative '../spaces/model'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../frameworks/framework'
require_relative '../environments/environment'
require_relative '../packages/packages'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative '../bindings/bindings'
require_relative '../users/user'

module Installations
  class Installation < ::Spaces::Model

    class << self
      def blueprint_classes
        @@blueprint_classes ||= {
          framework: Frameworks::Framework,
          os_packages: OsPackages::OsPackages,
          nodules: [Nodules::Nodules, :modules],
          packages: Packages::Packages,
          bindings: Bindings::Bindings,
          environment: Environments::Environment
        }
      end

      def output_classes
        @@output_classes ||= {
          docker_file: Docker::Files::File,
          image_subject: Images::Subject
        }
      end

      def installation_classes
        @@installation_classes ||= {
          user: Users::User,
          domain: Domains::Domain
        }
      end

      def all_classes
        @@all_classes ||= blueprint_classes.merge(output_classes).merge(installation_classes)
      end

      def savable_collaborator_keys
        [:bindings, :environment, :domain]
      end
    end

    relation_accessor :blueprint

    def text_file_names
      blueprint.text_file_names
    end

    def all_classes
      self.class.all_classes
    end

    def output_classes
      self.class.output_classes
    end

    def installation_classes
      self.class.installation_classes
    end

    def savable_collaborator_keys
      self.class.savable_collaborator_keys
    end

    def collaborators
      @classes ||= keys.reduce({}) do |m, k|
        v = [all_classes[k]].flatten
        m[k] = v.first.prototype(installation: self, section: k) if collaborator_blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_blueprinted?(key)
      v = [all_classes[key]].flatten
      struct[v[1] || key]
    end

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def savable_collaborators
      savable_collaborator_keys.map { |k| collaborators[k] }
    end

    def keys
      all_classes.keys
    end

    def necessary_keys
      output_classes.keys + installation_classes.keys
    end

    def initialize(blueprint)
      self.blueprint = blueprint
      self.struct = duplicate(blueprint.struct)
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
