require_relative '../installations/collaborator'
require_relative 'persistent_dir'

module PersistentDirs
  class PersistentDirs < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@persistent_dirs_step_precedence ||= { late: [:run_scripts] }
      end

      def script_lot
        @@persistent_dirs_script_lot ||= [:persistent_dirs]
      end
    end

    def all
      @all ||= installation.struct.persistent_dirs.map { |s| persistent_dir_class.new(struct: s, context: self) }
    end

    def persistent_dir_class
      PersistentDir
    end

  end
end
