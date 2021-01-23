module Emissions
  module Embedding

    def turtles; turtle_targets.map(&:blueprint) ;end
    def embeds; embed_targets.map(&:blueprint) ;end

    def turtle_targets; targets(:turtle_targets) ;end
    def embed_targets; targets(:embed_targets) ;end
    def targets(type); has?(:bindings) ? bindings.send(type) : [] ;end

  end
end
