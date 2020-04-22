require_relative '../collaborators/division'
require_relative 'os_package'

module OsPackages
  class OsPackages < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts

  end
end
