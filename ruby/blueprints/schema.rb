require_relative '../spaces/schema'
require_relative '../starters/starter'
require_relative '../frameworks/framework'
require_relative '../web_servers/web_server'
require_relative '../repositories/repositories'
require_relative '../sudos/sudos'
require_relative '../os_packages/os_packages'
require_relative '../nodules/nodules'
require_relative '../packages/packages'
require_relative '../replacements/replacements'
require_relative '../file_permissions/file_permissions'
require_relative '../environments/environment'
require_relative 'stage'

module Blueprints
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          title: 0,
          description: 0,
          memory_usage: [0, { required: 0, recommended: 0 }],
          protocol: 1,
          licenses: [(1..), { label: 1, url: 1 }],
          bindings: 0,
          stages: [
            (1..),
            {
              starter: 1,
              framework: 0,
              web_server: 0,
              repositories: 0,
              sudos: 0,
              os_packages: 0,
              modules: 0,
              packages: 0,
              replacements: 0,
              file_permissions: 0,
              environment: 0
            }
          ]
        }
      end

      def naming_map
        {
          nodules: :modules
        }
      end

      def collaborating_classes
        [
          Starters::Starter,
          Frameworks::Framework,
          WebServers::WebServer,
          Repositories::Repositories,
          Sudos::Sudos,
          OsPackages::OsPackages,
          Nodules::Nodules,
          Packages::Packages,
          Replacements::Replacement,
          FilePermissions::FilePermissions,
          Environments::Environment
        ]
      end
    end

  end
end
