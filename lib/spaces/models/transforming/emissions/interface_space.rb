module Emissions
  class InterfaceSpace < ::Spaces::DelegatedSpace
    #TODO: what happens when there are multiple interfaces?

    delegate(arenas: :universe)

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
        a.provider_for(provider_role).interface_for_all_in(identifier.singularize)
      end.flatten.uniq(&:uniqueness)
    end

    def provider_role; :runtime ;end

  end
end
