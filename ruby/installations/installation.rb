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
require_relative '../file_permissions/file_permissions'

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
          environment: Environments::Environment,
          file_permissions: FilePermissions::FilePermissions
        }
      end

      def product_classes
        @@product_classes ||= {
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
        @@all_classes ||= blueprint_classes.merge(product_classes).merge(installation_classes)
      end

      def blueprint_map
        @@blueprint_map ||= {
          nodules: :modules,
          anchor: :binding_anchor
        }
      end

      def mutable_divisions
        [:bindings, :user]
      end
    end

    def installation
      itself
    end

    def home_app_path
      descriptor.home_app_path
    end

    def identifier
      descriptor.identifier
    end

    def product
      struct.tap do |s|
        mutable_divisions.each do |k|
          if c = collaborators[k]
            s[blueprint_label_for(k)] = c.product
          end
        end
      end
    end

    def file_names_for(directory)
      universe.blueprints.file_names_for(directory, descriptor)
    end

    def all_classes
      self.class.all_classes
    end

    def product_classes
      self.class.product_classes
    end

    def installation_classes
      self.class.installation_classes
    end

    def mutable_divisions
      self.class.mutable_divisions
    end

    def blueprint_label_for(key)
      self.class.blueprint_map[key] || key
    end

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = all_classes[k].prototype(installation: self, blueprint_label: blueprint_label_for(k)) if blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def blueprinted?(key)
      struct[blueprint_label_for(key)]
    end

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def keys
      all_classes.keys
    end

    def necessary_keys
      product_classes.keys + installation_classes.keys
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
