require_relative '../collaborators/division'
require_relative 'schema'

module FilePermissions
  class FilePermissions < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def inheritance_paths; __dir__; end

      def schema_class
        Schema
      end
    end

    require_files_in :steps, :scripts

  end
end
