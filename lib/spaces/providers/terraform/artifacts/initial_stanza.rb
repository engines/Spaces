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
        provider_resolutions.map do |r|
          %(
            #{r.blueprint_identifier} = {
              version = "#{r.configuration.version}"
              source = "#{r.configuration.source}"
            }
          )
        end
      end

      def provider_resolutions
        provider_keys.map { |k| arena.send(k) }.uniq
      end

      def provider_keys
        super - [:provisioning]
      end

    end
  end
end
