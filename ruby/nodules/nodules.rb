require_relative '../installations/division'

module Nodules
  class Nodules < ::Installations::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def here; __dir__; end
    end

    require_files_in :steps

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, context: self)
    end

    def build_script_path
       "#{super}/modules"
    end

  end
end
