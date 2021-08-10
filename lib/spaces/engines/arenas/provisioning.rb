module Arenas
  module Provisioning

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(packs).select { |b| b.resolution&.provisionable? }
    end

    def unsaved_provisions; provisionables.reject(&:provisioned?) ;end
    def provisionables; bound_resolutions.select(&:provisionable?) ;end

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
