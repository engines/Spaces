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
require_relative '../repositories/repositories'

module Installations
  class Installation < ::Spaces::Model

    class << self
      def blueprint_classes
        [
          Frameworks::Framework,
          OsPackages::OsPackages,
          Nodules::Nodules,
          Packages::Packages,
          FilePermissions::FilePermissions,
          Bindings::Bindings,
          Bindings::Anchor,
          Environments::Environment,
          Sudos::Sudos,
          Repositories::Repositories
        ]
      end

      def product_classes
        [
          Docker::Files::File,
          Images::Subject
        ]
      end

      def installation_classes
        [
          Users::User,
          Domains::Domain
        ]
      end

      def division_map
        @@division_map ||= {
          nodules: :modules,
          anchor: :binding_anchor,
          file: :docker_file,
          subject: :image_subject
        }
      end

      def blueprint_divisions
        @@blueprint_divisions ||= map_for(blueprint_classes)
      end

      def product_collaborators
        @@product_collaborators ||= map_for(product_classes)
      end

      def installation_divisions
        @@installation_divisions ||= map_for(installation_classes)
      end

      def map_for(classes)
        classes.inject({}) do |m, k|
          m[key_for(k)] = k
          m
        end
      end

      def all_collaborators
        @@all_collaborators ||= blueprint_divisions.merge(installation_divisions).merge(product_collaborators)
      end

      def key_for(klass)
        mapped_key_for(klass.to_s.snakize.split('/').last.to_sym)
      end

      def mapped_key_for(key)
        division_map[key] || key
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
            s[k] = c.product
          end
        end
      end
    end

    def file_names_for(directory)
      universe.blueprints.file_names_for(directory, descriptor)
    end

    def collaborators
      @collaborators ||= keys.reduce({}) do |m, k|
        m[k] = collaborator_for(k) if blueprinted?(k) || collaborate_anyway?(k)
        m
      end.compact
    end

    def collaborator_for(key)
      all_collaborators[key].prototype(installation: self, blueprint_label: key)
    end

    def blueprinted?(key)
      struct[key]
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
