require_relative '../releases/division'

module Nodules
  class Nodules < ::Releases::Division

    class << self
      def step_precedence
        { late: [:run] }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end
