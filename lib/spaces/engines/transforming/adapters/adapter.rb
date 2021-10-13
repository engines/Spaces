require_relative 'precedence'

module Adapters
  class Adapter < ::Spaces::Model
    include Adapters::Precedence

    relation_accessor :division

    def snippet_map
      @snippet_map ||= {}.tap { |m| m[qualifier] = snippets }.compact
    end

    # def precedence; middle_order ;end

    # delegate [:arena, :configuration, :runtime_qualifier, :blueprint_identifier, :qualifier, :type] => :division
    #
    # def resolution_snippets_for(_); ;end
    #
    # def container_type
    #   [runtime_qualifier, 'container'].compact.join('_')
    # end
    # TODO: find the right place for this

    def temporary_script_path; temporary_path.join(script_path) ;end
    def temporary_path; Pathname('/tmp') ;end
    def script_path; 'packing/scripts' ;end

    def initialize(division)
      self.division = division
    end

  end
end
