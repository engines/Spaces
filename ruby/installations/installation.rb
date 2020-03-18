require_relative '../spaces/model'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../frameworks/framework'
require_relative '../environments/environment'
require_relative '../packages/packages'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../users/user'

module Installations
  class Installation < ::Spaces::Model

    class << self
      def blueprint_classes
        @@blueprint_classes ||= {
          framework: Frameworks::Framework,
          os_packages: OsPackages::OsPackages,
          nodules: Nodules::Nodules,
          packages: Packages::Packages,
          bindings: Bindings::Bindings,
          anchor: Bindings::Anchor,
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

      def section_map
        @@section_map ||= {
          nodules: :modules,
          anchor: :binding_anchor
        }
      end

      def resolvable_collaborator_keys
        [:bindings, :user]
      end
    end

    def identifier
      descriptor.identifier
    end

    def product
      struct.tap do |s|
        resolvable_collaborator_keys.each do |k|
          if c = collaborators[k]
            s[section_for(k)] = c.product
          end
        end
      end
    end

    def text_file_names
      universe.blueprints.text_file_names_for(descriptor)
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

    def resolvable_collaborator_keys
      self.class.resolvable_collaborator_keys
    end

    def section_for(key)
      self.class.section_map[key] || key
    end

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = all_classes[k].prototype(installation: self, section: section_for(k)) if collaborator_blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_blueprinted?(key)
      struct[section_for(key)]
    end

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def keys
      all_classes.keys
    end

    def necessary_keys
      output_classes.keys + installation_classes.keys
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
