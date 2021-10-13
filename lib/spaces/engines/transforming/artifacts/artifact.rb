module Artifacts
  class Artifact < ::Spaces::Model
    include Adapters::Precedence

    relation_accessor :adapter

    delegate(
      division_adapters: :adapter
    )

    def value
      [snippets].flatten.join("\n") #TODO: is this a good default?
    end

    def snippets
      no_stanzas? ? snippets_here : stanzas.map(&:snippets)
    end

    def snippets_here
      precedence.map { |p| snippet_map[p] }.compact
    end

    def snippet_map
      @snippet_map ||= division_adapters.reduce({}) do |m, a|
        m.tap do
          a.snippet_map.keys.map do |k|
            p = precedence_for(k)
            m[p] = [m[p], a.snippet_map[k]].flatten.compact
          end
        end
      end
    end

    def no_stanzas?; stanza_qualifiers.empty? ;end

    def stanza_qualifiers; [] ;end

    def stanzas
      @stanzas ||= stanza_qualifiers.map { |q| stanza_class_for(q).new(self) }
    end

    def stanza_class_for(qualifier)
      qualifier
    end

    # def keys; division_adapter_map.keys ;end

    # def adapter_for(key)
    #   division_adapter_map[key].snippets
    # end
    #
    # def snippet_map
    #   @snippet_map ||= keys.inject({}) do |m, k|
    #     m.tap { m[k] = snippets_for(k) }
    #   end.compact
    # end

    def initialize(adapter)
      self.adapter = adapter
    end

  end
end
