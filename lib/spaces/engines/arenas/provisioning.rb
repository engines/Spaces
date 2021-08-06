module Arenas
  module Provisioning

    def unprovisioned
      deep_connect_bindings.reject do |b|
        provisioning.exist?(b.settlement_identifier_in(self))
      end.select do |b|
        b.resolution_in(self)&.provisionable?
      end
    end

    def provisionables; bound_resolutions.select(&:provisionable?) ;end

    def unsaved_provisions; provisionables.reject(&:provisioned?) ;end

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
      runtime_provider.provider_aspect.provider_stanzas
    end

  end
end
