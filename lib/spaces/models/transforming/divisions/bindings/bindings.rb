module Divisions
  class Bindings < ::Divisions::Divisible

    alias_method :all_bindings, :all # NOW WHAT?

    def complete?; all_complete?(all) ;end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def flattened # NOW WHAT?
      empty.tap { |d| d.struct = all.map(&:flattened).map(&:struct) }
    end

    def graphed(type: :all, emission: emission_type, direction: nil)
      empty.tap do |d|
        d.struct = send("#{type}_bindings").map { |b| b.graphed(emission) }.compact.map(&:struct) # NOW WHAT?
      end
    end

    def transformed_to(transformation)
      in_blueprint? ? super : super.select do |s| # NOW WHAT?
        s.for_runtime?(runtime_qualifier)
      end
    end

    def embed_bindings # NOW WHAT?
      all.select(&:embed?).map(&:embed_bindings).flatten.uniq
    end

    def connect_bindings # NOW WHAT?
      all.reject(&:embed?)
    end

    def deep_connect_bindings # NOW WHAT?
      deep_bindings.reject { |b| b.embed? || b.binder? }
    end

    def deep_binder_bindings # NOW WHAT?
      deep_bindings.select(&:binder?)
    end

    def deep_bindings # NOW WHAT?
      all.map(&:deep_bindings).flatten.uniq
    end

    def descriptors
      all.map(&:descriptor).compact
    end

    def emission_type; emission.qualifier ;end

    def method_missing(m, *args, &block); named(m) || super ;end
    def respond_to_missing?(m, *); named(m) || super ;end

  end
end
