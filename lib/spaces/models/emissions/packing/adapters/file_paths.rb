module Adapters
  module FilePaths

    def file_source_paths_for(precedence)
      pp resolutions.path_for(pack).children
      resolutions.path_for(pack).children.select do |c|
        c.directory? && pack.auxiliary_directories.include?(:"#{c.basename}")
      end

    end

    def scripts_for(precedence)
      resolutions.file_names_for("#{path}/#{precedence}", pack.context_identifier).map(&:basename)
    end

  end
end
