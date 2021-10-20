require_relative 'precedence'

module Adapters
  class Adapter < ::Spaces::Model
    include Adapters::Precedence

    relation_accessor :division

    def snippet_map
      @snippet_map ||= {}.tap { |m| m[qualifier] = snippets }.compact
    end

    def snippets; ;end

    # TODO: find the right place for this
    def temporary_script_path; temporary_path.join(script_path) ;end
    def temporary_path; Pathname('/tmp') ;end
    def script_path; 'packing/scripts' ;end

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