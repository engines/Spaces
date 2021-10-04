module Arenas
  module Provisioning

    def provider_aspect
      @provider_aspect ||= ::Providers::Terraform::ArenaAspect.new(self)
    end

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(provisioning).select { |b| b.resolution_in(self)&.provisionable? }
    end

    def unsaved_provisions; provisionables.reject(&:provisioned?) ;end
    def provisionables; bound_resolutions.select(&:provisionable?) ;end

  end
end
