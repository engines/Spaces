module Adapters
  class DivisionAdapter < ::Spaces::Model

    relation_accessor :division

    # delegate [:arena, :configuration, :runtime_qualifier, :blueprint_identifier, :qualifier, :type, :temporary_script_path] => :division
    #
    # def resolution_stanzas_for(_); ;end
    #
    # def container_type
    #   [runtime_qualifier, 'container'].compact.join('_')
    # end

    def initialize(division)
      self.division = division
    end

  end
end
