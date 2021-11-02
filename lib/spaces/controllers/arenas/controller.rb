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
          init: [::Spaces::Commands::Executing, {execute: :init, threaded: true}],
          plan: [::Spaces::Commands::Executing, {execute: :plan, threaded: true}],
          show: [::Spaces::Commands::Executing, {execute: :show, threaded: true}],
          apply: [::Spaces::Commands::Executing, {execute: :apply, threaded: true}]
        })
      end

    end
  end
end
