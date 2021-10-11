module Artifacts
  class Artifact < ::Spaces::Model

    relation_accessor :adapter
    relation_accessor :holder

    delegate(
      division_adapter_map: :adapter
    )

    def value
      snippet_map.values.join("\n") #TODO: is this a good default?
    end

    def snippet_map
      @snippet_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = snippets_for(k) }
      end.compact
    end

    def keys; division_adapter_map.keys ;end

    def snippets_for(key)
      division_adapter_map[key].snippets
    end

    def initialize(adapter, holder = nil)
      self.adapter = adapter
      self.holder = holder
    end

  end
end
