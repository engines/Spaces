require_relative '../collaborators/division'

module Environments
  class Environment < ::Collaborators::Division

    class << self
      def inheritance_paths; __dir__ ;end
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
