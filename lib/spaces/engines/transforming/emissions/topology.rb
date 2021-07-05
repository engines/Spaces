module Emissions
  module Topology

    def all_down(emission: :blueprint)
      all_bindings.map { |t| t.send(emission) }.compact
    end

    def connections_down(emission: :resolution)
      connect_bindings.map { |t| t.send(emission) }.compact
    end

    def embeds_down(emission: :blueprint)
      embed_bindings.map { |t| t.send(emission) }.compact
    end

    def runtime_embeds_for(runtime, emission: :blueprint)
      embed_bindings.select { |t| t.for_runtime?(runtime) }.map { |t| t.send(emission) }.compact
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
