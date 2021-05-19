module Emissions
  module Embedding

    def with_embeds
      empty.tap do |m|
        m.struct = m.struct.merge(
          OpenStruct.new(embedding_division_map.transform_values(&:struct))
        )
      end
    end

    def embedding_division_map
      embedding_keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k).with_embeds(embeds_including_self) }
      end
    end

    def embedding_keys
      @embedding_keys ||= [division_keys, embeds_down.map(&:division_keys)].flatten.uniq
    end

    def embeds_including_self; [itself, embeds_down].flatten.reverse ;end

  end
end
