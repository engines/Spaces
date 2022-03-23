module Arenas
  module Translating

    def artifacts_for(identifier)
      if (m = exist_then_by(identifier))
        translator(m).artifacts
      end
    end

    def save_artifacts_for(arena)
      ensure_space_for(arena)
      translator_for(arena)&.save_artifacts_to(writing_path_for(arena))
    end

    def translator_for(arena)
      arena.provisioning_provider.translator_for(arena)
    end

    protected

    def copy_auxiliaries_for(arena)
      arena.all_packs.each do |p|
        packs.copy_auxiliaries_for(p)
      end
    end

    def remove_auxiliaries_for(arena)
      arena.all_packs.each do |p|
        packs.remove_auxiliaries_for(p)
      end
    end

  end
end
