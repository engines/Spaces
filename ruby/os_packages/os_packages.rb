require_relative '../installations/division'
require_relative 'os_package'

module OsPackages
  class OsPackages < ::Installations::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts

    def build_script_path
      "#{super}/os_packages"
    end

    def subdivision_class
      OsPackage
    end

  end
end
