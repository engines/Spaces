module Arenas
  module Orchestrating

    def all_orchestrations
      orchestrations.identifiers(arena_identifier: identifier).map do |i|
        orchestrations.by(i)
      end
    end

    def orchestrated = present_in(orchestrations)

    def unorchestrated = absent_in(orchestrations)

    def unsaved_orchestration = bound_resolutions.reject(&:orchestrated?)

    def volume_path = input.volumes[:path]

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
