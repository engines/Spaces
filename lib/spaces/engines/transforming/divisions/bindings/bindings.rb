module Divisions
  class Bindings < ::Divisions::Divisible

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def flattened
      empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }
    end

    def graphed(type: :connect, emission: emission_qualifier, direction: nil)
      empty.tap do |d|
        d.struct = send("#{type}_bindings").map { |t| t.graphed(emission) }.map(&:struct)
      end
    end

    def connect_bindings
      all.reject(&:embed?)
    end

    def embed_bindings
      all.select(&:embed?).map(&:embed_bindings).flatten
    end

    def deep_bindings
      all.map(&:deep_bindings).flatten
    end

    def emission_qualifier; emission.qualifier ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
