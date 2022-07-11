module Arenas
  module Interfacing
    include Emissions::Providing

    def init(arena) = execute_on_orchestrater(:init, arena)
    def plan(arena) = execute_on_orchestrater(:plan, arena)
    def show(arena) = execute_on_orchestrater(:show, arena)
    def apply(arena) = execute_on_orchestrater(:apply, arena)

    def execute_on_orchestrater(command, arena) =
      interface_for(arena).execute(command)

    def provider_role = :orchestration

  end
end
