module Divisions
  module Embeddable

    def with_embeds(emissions)
      emissions.reduce(itself) do |m, b|
        b.respond_to?(qualifier) ? m.embedded_with(b.send(qualifier)) : m
      end
    end

    def embedded_with(other) =
      empty.tap { |d| d.struct = struct_merged_with(other) }

    def struct_merged_with(other) = struct.reverse_merge(other.struct)

    def no_embed_makes_sense = self

  end
end
