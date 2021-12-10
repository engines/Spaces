require_relative 'golden_packing'

module Arenas
  module Provisioning
    include ::Arenas::GoldenPacking

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(provisioning)
    end

    def unsaved_provisions; bound_resolutions.reject(&:provisioned?) ;end

  end
end
