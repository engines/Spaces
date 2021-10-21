module Emissions
  module Topology

    def all_identifiers_up_in(emissions)
      all_emissions_up_in(emissions).map(&:identifier)
    end

    def all_emissions_up_in(emissions)
      all_up_in(emissions).map(&:emission).uniq
    end

    def all_up_in(emissions)
      all_in(emissions).select { |b| identifier == b.target_identifier }
    end

    def all_in(emissions)
      emissions.map(&:all_bindings).flatten
    end

    def all_down(emission: :blueprint)
      all_bindings.map { |t| t.send(emission) }.compact
    end

    def connections_down(emission: :resolution)
      connect_bindings.map { |t| t.send(emission) }.compact
    end

    def embeds_down(emission: :blueprint)
      embed_bindings.map { |t| t.send(emission) }.compact
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
