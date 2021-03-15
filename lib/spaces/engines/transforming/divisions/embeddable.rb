module Divisions
  module Embeddable

    def with_embeds(emissions)
      emissions.reduce(itself) do |m, b|
        b.respond_to?(qualifier) ? m.embedded_with(b.send(qualifier)) : m
      end
    end

    def embedded_with(other)
      empty.tap { |d| d.struct = struct_with(other) }
    end

    def struct_with(other); struct.reverse_merge(other.struct) ;end

  end
end
