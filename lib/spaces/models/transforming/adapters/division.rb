require_relative 'adapter'

module Adapters
  class Division < Adapter

    relation_accessor :division

    def snippet_map
      @snippet_map ||= {}.tap { |m| m[qualifier] = snippets }.compact
    end

    def snippets; ;end

    def initialize(division)
      self.division = division
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
