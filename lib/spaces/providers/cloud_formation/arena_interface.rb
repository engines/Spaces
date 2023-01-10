require 'aws-sdk-cloudformation'

module Providers
  module CloudFormation
    class ArenaInterface < ::Providers::Interface

      alias_method :arena, :emission

      delegate(
        arenas: :universe,
        path_for: :arenas
      )

      def execute(command)
        identifier.tap { orchestration_for(command) }
      end

      protected

      def orchestration_for(command)
        send(command)
      end

      def plan
        bridge.validate_template(template_body: template)
      end

      def apply
        #TODO: cater for update_stack ... how do we figure out which to call?
        bridge.create_stack(
          stack_name: arena.identifier,
          template_body: template,
          parameters: []
        )
      end

      def bridge
        @bridge ||= ::Aws::CloudFormation::Client.new
      end

      def template
        @template ||= template_path.read
      end

      def template_path = arenas.path_for(arena).join('cloud-formation.yaml')

    end
  end
end
