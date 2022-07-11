module Adapters
  module ScriptPaths

    def temporary_script_paths_for(precedence)
      scripts_for(precedence).map do |s|
        temporary_script_path.join("#{precedence}", s)
      end
    end

    def scripts_for(precedence) =
      resolutions.file_names_for("#{path}/#{precedence}", pack.context_identifier).map(&:basename)

    def temporary_script_path = temporary_path.join(script_path)
    def temporary_path = Pathname('/tmp')
    def script_path = 'packing/scripts'

  end
end
