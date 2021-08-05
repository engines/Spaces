module Arenas
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :arenas ;end

      def action_command_map
        @action_command_map ||= super.merge({
          new: Commands::Saving,
          update: Commands::Saving,
          configure: Commands::Configuring,
          bind: Commands::Binding,
          more_binders: Commands::MoreBinders,
          install: [Commands::Installing, force: true],
          resolve: [Commands::Resolving, force: true],
          pack: [Commands::Packing, force: true],
          runtime: Commands::RuntimeBooting,
          provision: Commands::Provisioning,
          provision_providers: Commands::ProviderProvisioning,
          apply: [::Spaces::Commands::Executing, execute: :apply]
        })
      end

    end
  end
end
