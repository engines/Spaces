module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def init(model); execute_on_interface(:init, model) ;end
    def plan(model); execute_on_interface(:plan, model) ;end
    def show(model); execute_on_interface(:show, model) ;end
    def apply(model); execute_on_interface(:apply, model) ;end

    def execute_on_interface(command, model)
      model.provisioning_provider.interface_for(model, space).execute(command)
    end

  end
end
