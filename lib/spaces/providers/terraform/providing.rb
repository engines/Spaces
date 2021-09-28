module Providers
  module Terraform
    module Providing

      def initial_artifacts
        %(
          terraform {
            required_providers {
              #{provider_aspects.flatten.map(&:required_stanza).flatten.compact.join}
            }
          }
        )
      end

      def runtime_artifacts
        runtime_aspect.provider_stanzas
      end

    end
  end
end
