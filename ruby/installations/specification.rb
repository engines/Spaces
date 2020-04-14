require_relative '../frameworks/framework'
require_relative '../repositories/repositories'
require_relative '../sudos/sudos'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative '../packages/packages'
require_relative '../replacements/replacements'
require_relative '../file_permissions/file_permissions'
require_relative '../bindings/bindings'
require_relative '../bindings/anchor'
require_relative '../environments/environment'
require_relative '../docker/files/file'
require_relative '../images/subject'
require_relative '../users/user'

module Installations
  module Specification

    def blueprint_classes
      [
        Frameworks::Framework,
        Repositories::Repositories,
        Sudos::Sudos,
        OsPackages::OsPackages,
        Nodules::Nodules,
        Packages::Packages,
        Replacements::Replacement,        
        FilePermissions::FilePermissions,
        Bindings::Bindings,
        Bindings::Anchor,
        Environments::Environment
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

    def mutable_divisions
      [:bindings, :user]
    end

  end
end
