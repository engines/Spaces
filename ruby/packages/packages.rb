require_relative '../installations/division'
require_relative 'package'

module Packages
  class Packages < ::Installations::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def script_lot; end
      def inheritance_paths; __dir__; end
    end

    require_files_in :steps

    def build_script_path
      "#{super}/packages"
    end

    def subdivision_class
      Package
    end

  end
end
