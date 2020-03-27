require_relative '../installations/collaborator'
require_relative '../texts/file_text'

module Images
  class Subject < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }

    class << self
      def divisions
        @@subject_divisions ||= [:framework, :os_packages, :nodules, :packages, :bindings, :image_subject, :file_permissions]
      end

      def script_lot
        @@subject_script_lot ||= [:build_functions, :injections, :persistent_source, :set_user_identifier, :set_data_permissions]
      end
    end

    delegate(
      divisions: :klass,
      docker_file: :installation
    )

    def product
      [docker_file, collaborator_scripts, blueprinted_scripts, injections].flatten
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
      @collaborators ||= divisions.map { |c| installation.send(c) }.compact
    end

  end
end
