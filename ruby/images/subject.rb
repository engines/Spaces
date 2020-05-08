require_relative '../installations/collaborator'

module Images
  class Subject < ::Installations::Collaborator
    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :scripts, :steps

    delegate([:docker_file, :identifier] => :installation)

    def components
      [docker_file, collaborator_scripts, project_scripts, injections].flatten
    end

    def collaborator_scripts
      related_collaborators.map(&:scripts).flatten.compact.uniq(&:uniqueness)
    end

    def project_scripts; files_for(:scripts) ;end
    def injections; files_for(:injections) ;end

    def files_for(directory)
      installation.file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

  end
end
