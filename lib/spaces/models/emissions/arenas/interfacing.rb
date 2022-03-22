module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def init(arena); execute_on_provisioner(:init, arena) ;end
    def plan(arena); execute_on_provisioner(:plan, arena) ;end
    def show(arena); execute_on_provisioner(:show, arena) ;end
    def apply(arena); execute_on_provisioner(:apply, arena) ;end

    def execute_on_provisioner(command, arena)
      adapting_interface_for(arena, :provisioning).execute(command)
    end

    def adapting_interface_for(arena, purpose)
      arena.provisioning_provider.adapting_interface_for(arena, purpose: purpose, space: self)
    end

  end
end
