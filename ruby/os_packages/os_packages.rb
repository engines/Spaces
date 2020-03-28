require_relative '../installations/division'
require_relative 'os_package'

module OsPackages
  class OsPackages < ::Installations::Division

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def script_lot
        @@os_packages_script_lot ||= [:installation]
      end

      def step_precedence
        @@os_packages_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def build_script_path
      "#{super}/os_packages"
    end

    def subdivision_class
      OsPackage
    end

  end
end
