module Settling
  module Embedding

    def with_embeds
      empty.tap do |m|
        m.struct = m.struct.merge(
          OpenStruct.new(embedding_division_map.transform_values(&:struct))
        )
      end.bindings_flattened
    end

    def embedding_division_map
      embedding_keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k)&.with_embeds(runtime_embeds) }
      end.compact
    end

    def embedding_keys
      @embedding_keys ||= [division_keys, runtime_embeds.map(&:division_keys)].flatten.uniq
    end

    def embeds_including_blueprint
      [blueprint, runtime_embeds].flatten.compact.reverse
    end

    def runtime_embeds
      @runtime_embeds ||= runtime_embeds_for(runtime_identifier)
    end

    def bindings_flattened
      bindings&.any? ? _bindings_flattened : self
    end

    protected

    def _bindings_flattened
      empty.tap do |m|
        m.struct = struct
        m.struct.bindings = bindings.flattened.struct
        m.cache_primary_identifiers
      end
    end

  end
end
