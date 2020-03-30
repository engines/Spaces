require_relative '../installations/division'

module Environments
  class Environment < ::Installations::Division

    class << self
      def step_precedence
        { anywhere: [:variables, :locale, :ports] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps

    def variables
      struct.variables
    end

    def variable(name)
      variables.detect { |v| v.name == name.to_s }
    end

    def method_missing(m, *args, &block)
      (v = variable(m)) ? v.value : super
    end

  end
end
