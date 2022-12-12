module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Hash < ::Artifacts::Format

          def runtime_qualifier = name_elements[2].camelize

          def content =
            {
              "#{resource_identifier}":
                [name_snippet, configuration_snippet, tags_snippet, more_snippets].
                  inject({Type: "#{runtime_qualifier}::#{resource_type_here}",}) do |m, s|
                    m.merge(s || {})
                  end
            }

          def name_snippet =
            {name: resource_identifier}

          def configuration_snippet =
            configuration_hash.without(:tags)

          def tags_snippet =
            {tags: tags_hash}

          def more_snippets = nil

        end
      end
    end
  end
end
