module Arenas
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :arenas ;end

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          state: Commands::StateReading,
          update: Commands::Saving,
          connect: Commands::Connecting,
          bind: Commands::Binding,
          more_binders: Commands::MoreBinders,
          resolve: Commands::Resolving,
          pack: Commands::Packing,
          build: Commands::Building,
          provision: Commands::Provisioning,
          init: [::Spaces::Commands::Executing, {execute: :init, threaded: true}],
          plan: [::Spaces::Commands::Executing, {execute: :plan, threaded: true}],
          # show: [::Spaces::Commands::Executing, {execute: :show, threaded: true}],
          apply: [::Spaces::Commands::Executing, {execute: :apply, threaded: true}],
          artifacts: [::Spaces::Commands::Artifacts, {space: :arenas}]
        })
      end

    end
  end
end
