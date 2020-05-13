require_relative '../releases/division'
require_relative 'replacement'

module Replacements
  class Replacements < ::Releases::Division

    class << self
      def step_precedence
        { late: [:run_scripts] }
      end

      def script_lot ;end
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps

  end
end
