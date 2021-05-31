module Providers
  class ProviderAspect < ::Spaces::Model

    class << self
      def prototype(division)
        constant_for(division).new(division)
      end

      def constant_for(division)
        Module.const_get(class_name_for(division))
      end

      def class_name_for(division)
        division.provider_aspect_name_elements.compact.map(&:camelize).join('::')
      end
    end

    relation_accessor :division

    delegate [:arena, :configuration, :runtime_identifier, :blueprint_identifier, :qualifier, :type] => :division

    def resolution_stanzas_for(_); ;end

    def container_type
      [runtime_identifier, 'container'].compact.join('_')
    end

    def initialize(division)
      self.division = division
    end

  end
end
