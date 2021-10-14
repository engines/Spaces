module Arenas
  module Provisioning

    # def provider_aspect
    #   @provider_aspect ||= ::Providers::Terraform::ArenaAspect.new(self)
    # end

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(provisioning)
    end

    def unsaved_provisions; bound_resolutions.reject(&:provisioned?) ;end

  end
end
