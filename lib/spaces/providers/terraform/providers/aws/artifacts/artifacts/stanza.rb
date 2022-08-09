require_relative 'named'
require_relative 'task_defining'

module Artifacts
  module Terraform
    module Aws
      class Stanza < ::Artifacts::Stanza

        class << self
          def default_configuration = OpenStruct.new

          def configuration_key_map =
            {
              cpus: :cpu
            }
        end

        delegate(
          [:default_configuration, :configuration_key_map] => :klass
        )

        def snippets =
          %(
            resource "aws_#{resource_type_here}" "#{application_identifier}" {
              #{name_snippet}
              #{configuration_snippet}
              #{tags_snippet}
              #{more_snippets}
            }
          )

        def application_identifier = resolution.identifier.split_compound.join('-').hyphenated

        def name_snippet = nil

        def configuration_snippet =
          configuration_hash.without(:tags).to_hcl(enclosed: false)

        def tags_snippet =
          %(tags = {#{tags_hash.to_hcl(enclosed: false)}})

        def arena_resource_qualification_for(resource) =
          [arena.identifier, resource.identifier].join('_').hyphenated

        def arena_attachable_qualification_for(attachable) =
          [arena.identifier, configuration.send(attachable)].join('_').hyphenated

        def configuration
          @configuration ||= default_configuration.reverse_merge(super)
        end

        def configuration_hash =
          with_tailored_keys(configuration&.to_h_deep || {})

        def with_tailored_keys(hash) =
          hash.transform_keys { |k| configuration_key_map[k] || k }

        def tags_hash =
          {
            'Name': application_identifier,
            'Environment': 'var.app_environment'
          }.merge(configuration_hash[:tags] || {})

        def more_snippets = nil

      end
    end
  end
end
