module Pods
  class Space < ::Provisioning::Space

    def interface_for(pod)  #TODO: refactor
      pod.arena.runtime_provider.interface_for(pod)
    end

  end
end
