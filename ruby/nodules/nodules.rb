require_relative '../collaborators/division'

module Nodules
  class Nodules < ::Collaborators::Division

    class << self
      def step_precedence
        { late: [:runs] }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end
