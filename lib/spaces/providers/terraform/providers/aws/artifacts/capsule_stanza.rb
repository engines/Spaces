module Artifacts
  module Terraform
    module Aws
      class CapsuleStanza < ::Artifacts::Terraform::CapsuleStanza

        # def snippets
        #   "# capsule resource snippet for #{blueprint_identifier} with nothing to say."
        # end
        def snippets
          %(
            resource "aws_#{resource_type}" "#{blueprint_identifier}" {
              name = "#{blueprint_identifier}"
              #{configuration_snippet}
              #{tags_snippet}
              #{more_snippets}
            }
          )
        end

        def resource_type; qualifier.split('_')[0..-2].join('_') ;end

        def configuration_snippet
          configuration_hash.without(:tags).to_hcl.join("\n")
        end

        def tags_snippet
          %(
            tags = {
              #{tags_hash.to_hcl.join("\n")}
            }
          )
        end

        def configuration_hash
          resolution.configuration&.struct&.to_h_deep || {}
        end

        def tags_hash
          {
            'Name': '${var.app_name}',
            'Environment': 'var.app_environment'
          }.merge(configuration_hash[:tags] || {})
        end

        def more_snippets ;end

      end
    end
  end
end
