require_relative '../releases/division'
require_relative 'sudo'

module Sudos
  class Sudos < ::Releases::Division

    class << self
      def step_precedence
        { late: [:run] }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps, :scripts
    
  end
end
