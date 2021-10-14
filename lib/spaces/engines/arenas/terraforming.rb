module Arenas
  module Terraforming
    include ::Spaces::Streaming

    def terraform_init(model); execute_on_aspect(:init, model) ;end
    def terraform_plan(model); execute_on_aspect(:plan, model) ;end
    def terraform_show(model); execute_on_aspect(:show, model) ;end
    def terraform_apply(model); execute_on_aspect(:apply, model) ;end

    def execute_on_aspect(command, model)
      provider_interface_for(model, space).execute(command, model)
    end

  end
end
