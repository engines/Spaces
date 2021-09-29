module ProviderAspects
  class Aspect < ::Spaces::Model

    class << self
      def prototype(division)
        constant_for(division).new(division)
      rescue NameError
        division
      end

      def constant_for(division)
        Module.const_get(class_name_for(division))
      end

      def class_name_for(division)
        division.aspect_name_elements.compact.map(&:camelize).join('::')
      end
    end

    relation_accessor :division

    delegate [:arena, :configuration, :blueprint_identifier, :runtime_identifier, :qualifier, :type, :temporary_script_path] => :division

    def resolution_stanzas_for(_); ;end

    def container_type
      [runtime_identifier, 'container'].compact.join('_')
    end

    def initialize(division)
      self.division = division
    end

  end
end
