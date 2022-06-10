module Artifacts
  module Terraform
    class InitialStanza < ::Artifacts::Stanza

      # def snippets
      #   %(
      #     terraform {
      #       required_providers {
      #         #{required_providers_snippets.join}
      #       }
      #     }
      #   )
      # end

      def snippets
        %(
          terraform {
            required_providers {
              aws = {
                source  = "hashicorp/aws"
                version = "2.70.0"
              }
            }
          }
        )
      end

      def required_providers_snippets
        required_providers.map do |r|
          %(
            #{r.application_identifier} = {
              version = "#{r.configuration.version}"
              source = "#{r.configuration.source}"
            }
          )
        end
      end

      def required_providers
        #TODO: how to find the providers?
        []
      end

    end
  end
end
