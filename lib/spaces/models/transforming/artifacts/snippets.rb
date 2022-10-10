module Artifacts
  module Snippets

    def snippets =
      no_stanzas? ? snippets_here : stanzas.map(&:snippets)

    def snippets_here =
      precedence.map { |p| snippet_map[p] }.compact

    def snippet_map
      @snippet_map ||= adapters.reduce({}) do |m, a|
        m.tap do
          a.snippet_map.keys.map do |k|
            p = precedence_for(k)
            m[p] = [m[p], a.snippet_map[k]].flatten.compact
          end
        end
      end
    end

    def snippet_keys =  snippet_map.keys

    def no_stanzas? = stanza_qualifiers.empty?

    def stanza_qualifiers = []

    def stanzas
      @stanzas ||= stanza_qualifiers.map { |q| stanza_class_for(q).new(self) }
    end

    def stanza_class_for(qualifier)
      class_for(nesting_elements, "#{qualifier}_stanza")
    rescue NameError => e
      warn(error: e, method: :stanza_class_for,
        elements: nesting_elements, identifier: emission.identifier
      )
      class_for(nesting_elements.drop(1), "#{qualifier}_stanza")
    end

  end
end
