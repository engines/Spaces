require_relative 'golden_packing'

module Arenas
  module Orchestrating
    include ::Arenas::GoldenPacking

    def orchestrated; present_in(orchestrations) ;end

    def unorchestrated
      absent_in(orchestrations)
    end

    def unsaved_orchestration; bound_resolutions.reject(&:orchestrated?) ;end

    def volume_path; input.volumes[:path] ;end

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
