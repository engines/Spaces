require_relative '../collaborators/collaborator'
require_relative 'os_package'

module OsPackages
  class OsPackages < ::Collaborators::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def script_precedence
        @@os_packages_script_precedence ||= [:installation]
      end

      def step_precedence
        @@os_packages_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def all
      @all ||= tensor.struct.os_packages.map { |s| os_package_class.new(struct: s, context: self) }
    end

    def build_script_path
      "#{super}/os_packages"
    end

    def os_package_class
      OsPackage
    end

  end
end
