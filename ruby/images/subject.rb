require_relative '../installations/collaborator'
require_relative '../texts/file_text'

module Images
  class Subject < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*/*"].each { |f| require f }

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
      [reduced_scripts, texts].flatten
    end

    def reduced_scripts
      all_scripts.uniq(&:uniqueness)
    end

    def all_scripts
      collaborators.map(&:scripts).flatten.compact
    end

    def texts
      installation.text_file_names.map { |t| text_class.new(source_file_name: t, context: self) }
    end

    def text_class
      Texts::FileText
    end

    def collaborators
      script_collaborators.map { |c| installation.send(c) }.compact
    end

    # def framework_build_script_path
    #   installation.framework&.build_script_path
    # end
  end
end
