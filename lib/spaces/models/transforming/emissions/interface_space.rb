module Emissions
  class InterfaceSpace < ::Spaces::DelegatedSpace
    #TODO: what happens when there are multiple interfaces?

    delegate(arenas: :universe)

    def identifiers(arena_identifier: nil, blueprint_identifier: nil, runtime: nil)
      summaries(arena_identifier: arena_identifier, blueprint_identifier: blueprint_identifier, runtime: runtime).map(&:identifier)
    end

    def summaries(arena_identifier: nil, blueprint_identifier: nil, runtime: nil)
      _summaries(arena_identifier: arena_identifier, blueprint_identifier: blueprint_identifier, runtime: runtime)
    end

    def _summaries(args)
      if (a = args.compact).empty?
        all
      else
        a.keys.map do |k|
          all.select { |s| s.send(k).to_sym == a[k].to_sym }
        end.flatten.uniq
      end
    end

    def by(identifier)
      interfaces.map { |i| i.by(identifier) }.first
    end

    def delete(identifier)
      by(identifier).execute(:delete)
    end

    def execute(instruction, identifier)
      by(identifier).execute(instruction)
    end

    def interfaces
      arenas.all.map do |a|
        a.provider_for(provider_role)&.interface_for_all_in(identifier.singularize)
      end.flatten.compact.uniq(&:uniqueness)
    end

    def provider_role; :runtime ;end

  end
end
