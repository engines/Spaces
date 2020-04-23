require_relative '../collaborators/division'
require_relative 'active_schema'

module FilePermissions
  class FilePermissions < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts

    def schema_class
      ActiveSchema
    end

  end
end
