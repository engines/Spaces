module Emissions
  class KeyedDivision < Division

    delegate(resolutions: :universe)

    def embed(other)
      tap do
        keys_including(other).each do |k|
          struct[k] = [struct[k], other.struct[k]].flatten.compact.uniq
        end
      end
    end

    def keys_including(other)
      [keys, other.keys].flatten.uniq
    end

    def packing_stanzas
       keys.map { |k| packing_stanza_for(k) }
    end

  end
end
