module Emissions
  module Topology

    def connections_down(emission: :resolution)
      connect_targets.map { |t| t.send(emission) }
    end

    def embeds_down(emission: :blueprint)
      embed_targets.map { |t| t.send(emission) }
    end

    def graphed(**args)
      empty.tap do |m|
        m.struct = struct
        m.struct.tap do |s|
          s.bindings = bindings.graphed(**args).struct
        end
      end
    end

  end
end
