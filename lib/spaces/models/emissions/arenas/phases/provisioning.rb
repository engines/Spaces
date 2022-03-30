require_relative 'golden_packing'

module Arenas
  module Provisioning
    include ::Arenas::GoldenPacking

    def provisioned; present_in(provisioning) ;end

    def unprovisioned
      absent_in(provisioning)
    end

    def unsaved_provisions; bound_resolutions.reject(&:provisioned?) ;end

    def volume_path; input.volumes[:path] ;end

    protected

    def copy_auxiliaries
      all_packs.each do |p|
        packs.copy_auxiliaries_for(p)
      end
    end

    def remove_auxiliaries
      all_packs.each do |p|
        packs.remove_auxiliaries_for(p)
      end
    end

  end
end
