require_relative '../installations/division'
require_relative 'sudo'

module Sudos
  class Sudos < ::Installations::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts

    def build_script_path
      "#{super}/sudoers"
    end

    def subdivision_class
      Sudo
    end

  end
end
