require_relative '../resolutions/division'

module Images
  class Subject < ::Resolutions::Division

    delegate([:identifier] => :resolution)

    def components
      [blueprint_scripts, injections].flatten
    end

    def blueprint_scripts; files_for(:scripts) ;end

    def injections; files_for(:injections) ;end

    def files_for(directory)
      resolution.blueprint_file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

  end
end
