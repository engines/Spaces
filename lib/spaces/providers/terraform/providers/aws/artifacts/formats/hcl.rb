module Artifacts
  module Terraform
    module Aws
      module Formats
        class Hcl < ::Artifacts::Format

          def content =
            %(
              resource "aws_#{resource_type}" "#{resource_identifier}" {
                #{name_snippet}
                #{configuration_snippet}
                #{tags_snippet}
                #{more_snippets}
              }
            )

          def resource_identifier = super.abbreviated_to(maximum_identifier_length)

          def name_snippet =
            %(name = "#{resource_identifier}")

          def configuration_snippet =
            configuration_hash.without(:tags).to_hcl(enclosed: false)

          def tags_snippet =
            %(tags = {#{tags_hash.to_hcl(enclosed: false)}})

          def more_snippets = nil

          def qualification_for(attachable) =
            super.hyphenated.abbreviated_to(maximum_identifier_length)

          def maximum_identifier_length = 32

          def resource_type_map_class = ResourceTypeMap

        end
      end
    end
  end
end
