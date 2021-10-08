module Providers
  module Artifact

    def artifact
      stanza_map.values.join("\n") #TODO: is this a good default?
    end

    def snippet_map
      @snippet_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = snippets_for(k) }
      end.compact
    end

    def keys; division_adapter_map.keys ;end

    def snippets_for(key)
      division_adapter_map[key].snippets
      # if (d = division_adapter_map[key])&.respond_to?(:snippets)
      #   d.snippets
      # end
    end
    end
  end
end
