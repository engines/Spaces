require_relative 'named'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class Stanza < ::Artifacts::Stanza

        def snippets
          %(
            resource "aws_#{resource_type_here}" "#{application_identifier}" {
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
