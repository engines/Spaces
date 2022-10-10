module Spaces
  class Space < Model

    def universe = universes.send(universe_identifier)

  end
end
