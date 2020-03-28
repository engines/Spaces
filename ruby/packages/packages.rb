require_relative '../installations/division'
require_relative 'package'

module Packages
  class Packages < ::Installations::Division

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@packages_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def build_script_path
      "#{super}/packages"
    end

    def subdivision_class
      Package
    end

  end
end
