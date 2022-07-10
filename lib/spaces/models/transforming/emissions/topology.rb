module Emissions
  module Topology

    def all_identifiers_up_in(emissions) =
      all_emissions_up_in(emissions).map(&:identifier)

    def all_emissions_up_in(emissions) =
      all_up_in(emissions).map(&:emission).uniq

    def all_up_in(emissions) =
      all_in(emissions).select { |b| identifier == b.target_identifier }

    def all_in(emissions) =
      emissions.map(&:all_bindings).flatten

    def all_down(emission: :blueprint) =
      all_bindings.map { |t| t.send(emission) }.compact

    def arena_runtime_embeds_for(runtime, emission: :blueprint) =
      bindings.embed_bindings_for(runtime).map { |t| t.send(emission) }

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
