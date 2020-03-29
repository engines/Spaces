require_relative '../installations/division'
require_relative 'file_permission'

module FilePermissions
  class FilePermissions < ::Installations::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps
    require_files_in :scripts

    def subdivision_class
      FilePermission
    end

  end
end
