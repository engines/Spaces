module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def init(arena); execute_on_provisioner(:init, arena) ;end
    def plan(arena); execute_on_provisioner(:plan, arena) ;end
    def show(arena); execute_on_provisioner(:show, arena) ;end
    def apply(arena); execute_on_provisioner(:apply, arena) ;end

    def execute_on_provisioner(command, arena)
      interface_for(arena, :provisioning).execute(command)
    end

    def interface_for(arena, purpose)
      arena.provisioning_provider.interface_for(purpose: purpose)
    end

  end
end
