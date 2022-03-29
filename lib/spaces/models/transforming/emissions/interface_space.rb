module Emissions
  class InterfaceSpace < ::Spaces::DelegatedSpace

    delegate(arenas: :universe)

    def by(identifier) #TODO: what happens when there are multiple interfaces?
      interfaces.map { |i| i.by(identifier) }.first
    end

    def delete(identifier) #TODO: what happens when there are multiple interfaces?
      interfaces.first.delete(identifier)
    end

    def interfaces
      arenas.all.map do |a|
        a.provider_for(provider_role).interface_for_all_in(identifier.singularize)
      end.flatten.uniq(&:uniqueness)
    end

    def provider_role; :runtime ;end

  end
end
