module Emissions
  class Space < ::Spaces::Space

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}".as_compound
      end
    end

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

    def interface_for(emission)
      emission.provider_for(provider_role).interface_for(emission)
    end

  end
end
