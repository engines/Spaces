module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def init(provisioning); execute_on_provisioner(:init, provisioning) ;end
    def plan(provisioning); execute_on_provisioner(:plan, provisioning) ;end
    def show(provisioning); execute_on_provisioner(:show, provisioning) ;end
    def apply(provisioning); execute_on_provisioner(:apply, provisioning) ;end

    def execute_on_provisioner(command, provisioning)
      interface_for(provisioning).execute(command)
    end

    def interface_for(provisioning)
      provisioning.provisioning_provider.interface_for(provisioning, purpose: :provisioning, space: space)
    end

  end
end
