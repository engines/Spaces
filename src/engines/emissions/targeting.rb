module Emissions
  module Targeting

    def turtles; turtle_targets.map(&:blueprint) ;end
    def turtle_targets; targets(:turtle_targets) ;end

    def connections; connect_targets.map(&:blueprint) ;end
    def connect_targets; targets(:connect_targets) ;end

    def targets(type); has?(:bindings) ? bindings.send(type) : [] ;end

  end
end
