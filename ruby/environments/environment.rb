require_relative '../releases/division'

module Environments
  class Environment < ::Releases::Division

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

    def method_missing(m, *args, &block); (v = variable(m)) ? v.value : super ;end
    def respond_to_missing?(m, *); variable(m) || super ;end

  end
end
