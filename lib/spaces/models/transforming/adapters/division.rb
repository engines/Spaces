require_relative 'adapter'

module Adapters
  class Division < Adapter

    relation_accessor :division
    relation_accessor :adapter

    delegate(struct: :division)

    def snippet_map
      @snippet_map ||= {}.tap { |m| m[qualifier] = snippets }.compact
    end

    def snippets = nil

    def initialize(division, adapter)
      self.division = division
      self.adapter = adapter
    end

    def method_missing(m, *args, &block)
      return division.send(m, *args, &block) if division.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      division.respond_to?(m) || super
    end

  end
end
