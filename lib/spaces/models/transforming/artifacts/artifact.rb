require_relative 'snippets'

module Artifacts
  class Artifact < ::Spaces::Model
    include Adapters::Precedence
    include Snippets

    relation_accessor :holder
    alias_method :adapter, :holder

    # delegate([:blueprint_identifier, :adapter_map, :adapter_keys] => :adapter)
    delegate([:adapter_map, :adapter_keys] => :adapter)

    def value
      [snippets].flatten.join("\n") #TODO: is this a good default?
    end

    def initialize(holder)
      self.holder = holder
    end

    def method_missing(m, *args, &block)
      return adapter_map[m] if adapter_keys.include?(m)
      return holder.send(m, *args, &block) if holder.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      adapter_map.include?(m) || holder.respond_to?(m) || super
    end

  end
end
