module Artifacts
  module Terraform
    module Aws
      module Formats
        class Hcl < ::Artifacts::Format

          def content =
            %(
              resource "aws_#{resource_type_here}" "#{resource_identifier}" {
                #{name_snippet}
                #{configuration_snippet}
                #{tags_snippet}
                #{more_snippets}
              }
            )

          def name_snippet =
            %(name = "#{resource_identifier}")

          def configuration_snippet =
            configuration_hash.without(:tags).to_hcl(enclosed: false)

          def tags_snippet =
            %(tags = {#{tags_hash.to_hcl(enclosed: false)}})

          def more_snippets = nil

        end
      end
    end
  end
end
