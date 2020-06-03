require_relative '../resolutions/division'

module Images
  class Subject < ::Resolutions::Division
    class << self
      def step_precedence
        {
          late: [:install],
          last: [:inject, :source_persistence, :finish]        
        }
      end

      def inheritance_paths; __dir__ ;end
    end
    
    require_files_in :scripts, :steps

    delegate([:docker_file, :identifier] => :resolution)

    def components
      [docker_file, division_scripts, blueprint_scripts, injections].flatten
    end

    def division_scripts
      related_divisions.map(&:scripts).flatten.compact.uniq(&:uniqueness)
    end

    def blueprint_scripts; files_for(:scripts) ;end

    def injections; files_for(:injections) ;end

    def files_for(directory)
      resolution.file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

  end
end
