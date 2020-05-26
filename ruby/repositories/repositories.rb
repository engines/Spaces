require_relative '../releases/division'
require_relative 'repository'

module Repositories
  class Repositories < ::Releases::Division

    class << self
      def step_precedence
        { late: [:run] }
      end

      def script_lot ;end
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps

    def subdivision_class
      Repository
    end

  end
end
