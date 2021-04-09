module Emissions
  module Topology

    def connections_down(emission: :resolution)
      connect_targets.map { |t| t.send(emission) }
    end

    def embeds_down(emission: :blueprint)
      embed_targets.map { |t| t.send(emission) }
    end

    def graph(type: :connections, direction: :down, emission: qualifier)
      [self, send("#{type}_#{direction}", emission: emission)]
    end

  end
end
