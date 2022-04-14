module Arenas
  module Interfacing
    include Emissions::Providing
    include ::Spaces::Streaming

    def init(arena); execute_on_orchestrater(:init, arena) ;end
    def plan(arena); execute_on_orchestrater(:plan, arena) ;end
    def show(arena); execute_on_orchestrater(:show, arena) ;end
    def apply(arena); execute_on_orchestrater(:apply, arena) ;end

    def execute_on_orchestrater(command, arena)
      interface_for(arena).execute(command)
    end

    def provider_role; :orchestration ;end

  end
end
