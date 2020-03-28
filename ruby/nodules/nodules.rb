require_relative '../installations/division'

module Nodules
  class Nodules < ::Installations::Division

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@nodules_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, context: self)
    end

    def build_script_path
       "#{super}/modules"
    end

  end
end
