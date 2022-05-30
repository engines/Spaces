require_relative 'tree'

module Targeting
  class Bindings < Tree

    alias_method :all_bindings, :all

    def graphed(type: :all, emission: emission_type, direction: nil)
      empty.tap do |d|
        d.struct = send("#{type}_bindings").map { |b| b.graphed(emission) }.compact.map(&:struct)
      end
    end

    def transformed_to(transformation)
      # TODO: cannot refer to blueprint here
      in_blueprint? ? super : super.select do |s|
        s.for_runtime?(qualifier_for(:runtime))
      end
    end

    def connect_bindings
      all.reject { |b| b.embed? || b.inject? }
    end

    def inject_bindings
      deep_bindings.select(&:inject?)
    end

    alias_method :configure_bindings, :inject_bindings

    def embed_bindings
      all.select(&:embed?)
    end

    def embed_bindings_for(runtime)
      ebs = shallow_embed_bindings_for(runtime)
      [ebs, ebs.map { |b| b.blueprint.bindings.embed_bindings_for(runtime) }].flatten.compact.uniq
    end

    def shallow_embed_bindings_for(runtime)
      embed_bindings.select { |t| t.for_runtime?(runtime) }
    end

    def deep_bindings
      all.map(&:deep_bindings).flatten.uniq
    end

  end
end
