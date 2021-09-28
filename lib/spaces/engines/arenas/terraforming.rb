module Arenas
  module Terraforming
    include ::Spaces::Streaming

    def init(model); execute_on_aspect(:init, model) ;end
    def plan(model); execute_on_aspect(:plan, model) ;end
    def show(model); execute_on_aspect(:show, model) ;end
    def apply(model); execute_on_aspect(:apply, model) ;end

    def execute_on_aspect(command, model)
      provider_aspect_for(model, space).execute(command, model)
    end

  end
end
