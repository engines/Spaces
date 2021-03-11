module Emissions
  module Targeting

    def bindings
      has?(:bindings) ? division_map[:bindings] : division_for(:bindings)
    end

    def turtles; turtle_targets.map(&:blueprint) ;end
    def turtle_targets; targets(:turtle_targets) ;end

    def connections; connect_targets.map{ |t| t.resolution_in(arena) } ;end
    def connect_targets; targets(:connect_targets) ;end

    def targets(type); bindings.send(type) ;end

  end
end
