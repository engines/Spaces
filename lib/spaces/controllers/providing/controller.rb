module Providing
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier = :providers

      def action_command_map
        @action_command_map ||= super.merge({
          application_qualifiers: [::Spaces::Commands::Querying, method: :application_qualifiers]
        })
      end

    end
  end
end
