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
require_relative '../sudos/sudos'
require_relative '../repositories/respositories'

module Installations
  class Installation < ::Spaces::Model

    class << self
      def blueprint_divisions
        @@blueprint_divisions ||= {
          framework: Frameworks::Framework,
          os_packages: OsPackages::OsPackages,
          nodules: Nodules::Nodules,
          packages: Packages::Packages,
          file_permissions: FilePermissions::FilePermissions,
          bindings: Bindings::Bindings,
          anchor: Bindings::Anchor,
          environment: Environments::Environment,
          sudo: Sudos::Sudos,
          repository: Respositories::Respositories
        }
      end

      def product_collaborators
        @@product_collaborators ||= {
          docker_file: Docker::Files::File,
          image_subject: Images::Subject
        }
      end

      def installation_divisions
        @@installation_divisions ||= {
          user: Users::User,
          domain: Domains::Domain
        }
      end

      def all_collaborators
        @@all_collaborators ||= blueprint_divisions.merge(installation_divisions).merge(product_collaborators)
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

    delegate(
      [
        :all_collaborators,
        :product_collaborators,
        :installation_divisions,
        :mutable_divisions
      ] => :klass,
      installation: :itself,
      [:identifier, :home_app_path] => :descriptor
    )

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

    def blueprint_label_for(key)
      klass.blueprint_map[key] || key
    end

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = collaborator_for(k) if blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_for(key)
      all_collaborators[key].prototype(installation: self, blueprint_label: blueprint_label_for(key))
    end

    def blueprinted?(key)
      struct[blueprint_label_for(key)]
    end

    def collaborate_anyway?(key)
      necessary_keys.include?(key)
    end

    def keys
      all_collaborators.keys
    end

    def necessary_keys
      product_collaborators.keys + installation_divisions.keys
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
