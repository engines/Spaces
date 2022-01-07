module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def init(model); execute_on_provisioner(:init, model) ;end
    def plan(model); execute_on_provisioner(:plan, model) ;end
    def show(model); execute_on_provisioner(:show, model) ;end
    def apply(model); execute_on_provisioner(:apply, model) ;end

    def execute_on_provisioner(command, model)
      model.provisioning_provider.interface_for(model, purpose: :provisioning, space: space).execute(command)
    end

  end
end
