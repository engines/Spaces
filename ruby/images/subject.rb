require_relative '../installations/collaborator'
require_relative '../texts/file_text'

module Images
  class Subject < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def script_collaborators
        @@subject_script_collaborators ||= [:framework, :os_packages, :nodules, :packages, :image_subject]
      end

      def script_lot
        @@subject_script_precedence ||= [
          :build_functions, :install_templates, :persistent_files,
          :persistent_dirs, :persistent_source, :recursive_write_permissions, :set_user_identifier, :set_data_permissions, :write_permissions
        ]
      end
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def product
      [collaborator_scripts, blueprinted_scripts, injections].flatten
    end

    def collaborator_scripts
      collaborators.map(&:scripts).flatten.compact.uniq(&:uniqueness)
    end

    def blueprinted_scripts
      files_for('scripts')
    end

    def injections
      files_for('injections')
    end

    def files_for(directory)
      installation.file_names_for(directory).map { |t| text_class.new(source_file_name: t, directory: directory, context: self) }
    end

    def text_class
      Texts::FileText
    end

    def collaborators
      script_collaborators.map { |c| installation.send(c) }.compact
    end

  end
end
