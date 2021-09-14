module Outputting
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :outputting ;end

      def action_command_map
        @action_command_map ||= super.merge({
          import: Commands::Import,
          export: Commands::Export,
          build: Commands::Build,
          init: [Commands::Execution, execute: :init],
          plan: [Commands::Execution, execute: :plan],
          apply: [Commands::Execution, execute: :apply],
        })
      end

    end
  end
end
