require_relative '../installations/division'
require_relative 'repositorie'

module Repositories
  class Repositories < ::Installations::Division

    class << self
      def step_precedence
        { early: [:run_scripts] }
      end

      def inheritance_paths; __dir__; end
    end

    require_files_in :steps, :scripts
    
  end
end
