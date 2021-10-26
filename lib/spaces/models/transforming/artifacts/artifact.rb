module Artifacts
  class Artifact < ::Spaces::Model
    include Adapters::Precedence

    relation_accessor :adapter

    delegate([:blueprint_identifier, :adapter_map, :adapter_keys] => :adapter)

    alias_method :filename, :qualifier

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
      @snippet_map ||= adapters.reduce({}) do |m, a|
        m.tap do
          a.snippet_map.keys.map do |k|
            p = precedence_for(k)
            m[p] = [m[p], a.snippet_map[k]].flatten.compact
          end
        end
      end
    end

    def snippet_keys; snippet_map.keys ;end

    def no_stanzas?; stanza_qualifiers.empty? ;end

    def stanza_qualifiers; [] ;end

    def stanzas
      @stanzas ||= stanza_qualifiers.map { |q| stanza_class_for(q).new(self) }
    end

    def stanza_class_for(qualifier)
      class_for(nesting_elements, "#{qualifier}_stanza")
    end

    def initialize(adapter)
      self.adapter = adapter
    end

    def method_missing(m, *args, &block)
      return adapter_map[m] if adapter_keys.include?(m)
      return adapter.send(m, *args, &block) if adapter.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      adapter_map.include?(m) || adapter.respond_to?(m) || super
    end

  end
end
