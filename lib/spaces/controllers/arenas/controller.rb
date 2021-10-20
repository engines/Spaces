module Arenas
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :arenas ;end

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          state: Commands::StateReading,
          update: Commands::Saving,
          bind: Commands::Binding,
          more_binders: Commands::MoreBinders,
          install: Commands::Installing,
          resolve: Commands::Resolving,
          pack: Commands::Packing,
          provision: Commands::Provisioning,
          # TODO: Generalise provisioning steps rather than terraform_<command>
          terraform_init: [::Spaces::Commands::Executing, {execute: :terraform_init, threaded: true}],
          terraform_plan: [::Spaces::Commands::Executing, {execute: :terraform_plan, threaded: true}],
          terraform_show: [::Spaces::Commands::Executing, {execute: :terraform_show, threaded: true}],
          terraform_apply: [::Spaces::Commands::Executing, {execute: :terraform_apply, threaded: true}]
        })
      end

    end
  end
end
