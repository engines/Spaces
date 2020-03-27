require_relative '../installations/division'

module Nodules
  class Nodules < ::Installations::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@nodules_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def scripts
      all.map(&:scripts)
    end

    def all
      @all ||= installation.struct.modules.map { |s| universe.nodules.by(struct: s, context: self) }
    end

    def build_script_path
       "#{super}/modules"
    end

  end
end
