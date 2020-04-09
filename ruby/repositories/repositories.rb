require_relative '../installations/division'
require_relative 'repository'

module Repositories
  class Repositories < ::Installations::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def script_lot; end
        def inheritance_paths; __dir__; end
      end
        
      require_files_in :steps
      
    def subdivision_class
      Repository
    end
    
  end
end
