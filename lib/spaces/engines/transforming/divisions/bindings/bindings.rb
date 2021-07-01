module Divisions
  class Bindings < ::Divisions::Divisible

    alias_method :all_bindings, :all

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def flattened
      empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }
    end

    def graphed(type: :all, emission: emission_type, direction: nil)
      empty.tap do |d|
        d.struct = send("#{type}_bindings").map { |b| b.graphed(emission) }.compact.map(&:struct)
      end
    end

    # FIX!
    def transformed_to(transformation)
      if runtime_identifier
        super.select { |s| [runtime_identifier, nil].include?(s.runtime) }
      else
        super
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

    def emission_type; emission.qualifier ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
