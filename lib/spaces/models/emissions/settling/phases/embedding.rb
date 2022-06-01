module Settling
  module Embedding

    def with_embeds
      empty.tap do |m|
        m.struct = struct.merge(
          OpenStruct.new(embedding_division_map.transform_values(&:struct))
        )
      end.bindings_flattened
    end

    def embedding_division_map
      embedding_keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k)&.with_embeds(embeds_for_arena_runtime) }
      end.compact
    end

    def embedding_keys
      @embedding_keys ||= [division_keys, embeds_for_arena_runtime.map(&:division_keys)].flatten.uniq
    end

    def embeds_including_blueprint
      [blueprint, embeds_for_arena_runtime].flatten.compact.reverse
    end

    def embeds_for_arena_runtime
      @embeds_for_arena_runtime ||= arena_runtime_embeds_for(qualifier_for(:runtime))
    end

    def bindings_flattened
      bindings&.any? ? _bindings_flattened : self
    end

    protected

    def _bindings_flattened
      empty.tap do |m|
        m.struct = struct
        m.struct.bindings = bindings.flattened.struct
        m.cache_primary_identifiers!
      end
    end

  end
end
