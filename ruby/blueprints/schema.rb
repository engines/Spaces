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

module Blueprints
  module Schema

    def division_classes
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

    def division_map
      {
        nodules: :modules,
        anchor: :binding_anchor
      }
    end

    def mutable_divisions
      [:bindings]
    end

  end
end
