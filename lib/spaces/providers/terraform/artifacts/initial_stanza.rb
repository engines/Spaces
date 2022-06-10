module Artifacts
  module Terraform
    class InitialStanza < ::Artifacts::Stanza

      def snippets
        %(
          terraform {
            required_providers {
              #{provider_snippets.join}
            }
          }
        )
      end

      def provider_snippets
        resolutions.map do |r|
          %(
            #{r.application_identifier} = {
              version = "#{r.configuration.version}"
              source = "#{r.configuration.source}"
            }
          )
        end
      end

      def resolutions
        #TODO: reimplement connecting to terraform provider initialization blueprints
        []
      end

    end
  end
end
