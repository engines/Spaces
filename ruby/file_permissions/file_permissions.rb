require_relative '../installations/division'
require_relative 'file_permission'

module FilePermissions
  class FilePermissions < ::Installations::Division

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@file_permissions_step_precedence ||= { late: [:run_scripts] }
      end

      def script_lot
        @@file_permissions_script_lot ||= [:file_permissions]
      end
    end

    def subdivision_class
      FilePermission
    end

  end
end
