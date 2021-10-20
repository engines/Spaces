module Arenas
  module Interfacing
    include ::Spaces::Streaming

    def terraform_init(model); execute_on_interface(:init, model) ;end
    def terraform_plan(model); execute_on_interface(:plan, model) ;end
    def terraform_show(model); execute_on_interface(:show, model) ;end
    def terraform_apply(model); execute_on_interface(:apply, model) ;end

    def execute_on_interface(command, model)
      model.provisioning_provider.interface_for(model).execute(command)
    end

  end
end
