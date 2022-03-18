module Runtime
  class Space < ::Provisioning::Space

    def interface_for(provisions)  #TODO: refactor
      provisions.arena.runtime_provider.interface_for(provisions, purpose: :runtime, space: space)
    end

  end
end
