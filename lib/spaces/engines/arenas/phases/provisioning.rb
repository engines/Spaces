module Arenas
  module Provisioning

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(provisioning)
    end

    def unsaved_provisions; bound_resolutions.reject(&:provisioned?) ;end

  end
end
