module Providers
  module Artifact

    def artifact
      stanza_map.values.join("\n") #TODO: is this a good default?
    end

    def stanza_map
      keys.inject({}) do |m, k|
        m.tap { m[k] = stanzas_for(k) }
      end.compact
    end

    def stanzas_for(key)
      division_map[key]&.stanzas
    end
  end
end
