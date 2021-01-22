module Emissions
  module Embedding

    def turtles; targets(:turtles) ;end
    def embeds; targets(:embeds) ;end
    def targets(type); has?(:bindings) ? bindings.send(type) : [] ;end

  end
end
