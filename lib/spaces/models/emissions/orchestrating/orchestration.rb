module Orchestrating
  class Orchestration < ::Resolving::Emission

    def connections_orchestrated = connections_down.map(&:orchestrated)

  end
end
