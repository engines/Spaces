module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Hash < ::Artifacts::Format

          def runtime_qualifier = name_elements[2]

          def content =
            {
              "#{resource_identifier}":
                [name_snippet, configuration_snippet, tags_snippet, more_snippets].
                  inject({Type: resource_type}) do |m, s|
                    m.merge(s || {})
                  end
            }.deep(:camelize, of: :keys)

          def resource_identifier = super.underscore.camelize

          def resource_type =
            "#{runtime_qualifier.upcase}_#{super}".amazonize

          def name_snippet =
            {name: resource_identifier}

          def configuration_snippet =
            configuration_hash.without(:tags)

          def tags_snippet =
            {tags: tags_hash}

          def tags_hash =
            {
              'Name': resource_identifier,
              'Environment': 'var.app_environment'
            }.merge(configuration_hash[:tags] || {})

          def more_snippets = nil

        end
      end
    end
  end
end
