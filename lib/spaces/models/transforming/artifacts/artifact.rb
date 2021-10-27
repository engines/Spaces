require_relative 'snippets'

module Artifacts
  class Artifact < ::Spaces::Model
    include Adapters::Precedence
    include Snippets

    relation_accessor :adapter

    delegate([:blueprint_identifier, :adapter_map, :adapter_keys] => :adapter)

    def value
      [snippets].flatten.join("\n") #TODO: is this a good default?
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
