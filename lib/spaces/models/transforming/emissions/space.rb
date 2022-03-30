module Emissions
  class Space < ::Spaces::PathSpace

    def artifacts_for(identifier)
      if (m = exist_then_by(identifier))
        translator_for(m).artifacts
      end
    end

    def save_artifacts_for(arena)
      ensure_space_for(arena)
      translator_for(arena)&.save_artifacts_to(writing_path_for(arena))
    end

    def translator_for(emission)
      emission.provider_for(provider_role).translator_for(emission)
    end

  end
end
