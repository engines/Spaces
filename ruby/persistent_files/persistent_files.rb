require_relative '../installations/collaborator'
require_relative 'persistent_file'

module PersistentFiles
  class PersistentFiles < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@persistent_files_step_precedence ||= { late: [:run_scripts] }
      end

      def script_lot
        @@persistent_files_script_lot ||= [:persistent_files]
      end
    end

    def all
      @all ||= installation.struct.persistent_files.map { |s| persistent_file_class.new(struct: s, context: self) }
    end

    def persistent_file_class
      PersistentFile
    end

  end
end
