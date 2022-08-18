module Orchestrating
  class Orchestration < ::Resolving::Emission

    # class << self
    #   def composition_class = Composition
    # end

    def connections_orchestrated = connections_down.map(&:orchestrated)

  end
end
