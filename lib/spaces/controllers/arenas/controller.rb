module Arenas
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :arenas

      def action_command_map
        @action_command_map ||= super.merge({
          create: Commands::Saving,
          state: Commands::StateReading,
          provide: Commands::Providing,
          update: Commands::Saving,
          connectables: [::Spaces::Commands::Querying, method: :connectables_for],
          connect: Commands::Connecting,
          stage: Commands::Staging,
          bind: Commands::Binding,
          resolve: Commands::Resolving,
          pack: Commands::Packing,
          orchestrate: Commands::Orchestrating,
          more_binders: Commands::MoreBinders,
          build_from: Commands::BuildingFrom,
          build: Commands::Building,
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
