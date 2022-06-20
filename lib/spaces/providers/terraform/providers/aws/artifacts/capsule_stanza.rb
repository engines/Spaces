require_relative 'named'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class CapsuleStanza < ::Artifacts::Terraform::CapsuleStanza

        class << self

          def resource_type_map
            {
              application_load_balancer: :alb,
              kms: :kms_key,
              container_definition: :ecs_container_definition,
              container_registry: :ecr_repository,
              container_service: :ecs_service,
              container_service_cluster: :ecs_cluster,
              load_balancer_listener: :lb_listener,
              load_balancer_target_group: :lb_target_group,
              log_group: :cloudwatch_log_group,
              container_task_definition: :ecs_task_definition
            }
          end
        end

        delegate resource_type_map: :klass

        def resource_type
          resource_type_map[compute_service_identifier&.to_sym] ||
            qualifier.split('_')[0..-2].join('_')
        end

        # def snippets
        #   "# capsule resource snippet for #{application_identifier} with nothing to say."
        # end
        def snippets
          %(
            resource "aws_#{resource_type}" "#{application_identifier}" {
              #{name_snippet}
              #{configuration_snippet}
              #{tags_snippet}
              #{more_snippets}
            }
          )
        end

        def name_snippet; end

        def configuration_snippet
          configuration_hash.without(:tags).to_hcl(enclosed: false)
        end

        def tags_snippet
          %(tags = {#{tags_hash.to_hcl(enclosed: false)}})
        end

        def configuration
          @configuration ||= default_configuration.reverse_merge(super)
        end

        def default_configuration; OpenStruct.new ;end

        def configuration_hash
          configuration&.to_h_deep || {}
        end

        def tags_hash
          {
            'Name': application_identifier,
            'Environment': 'var.app_environment'
          }.merge(configuration_hash[:tags] || {})
        end

        def more_snippets ;end

      end
    end
  end
end
