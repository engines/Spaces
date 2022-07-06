require_relative 'pack'
require_relative 'script_paths'

module Adapters
  class Scripting < Pack
    include Keyed
    include ScriptPaths

    alias_method :path, :script_path

    def has_scripts? = absolute_path.exist?

    def absolute_path
      @absolute_path ||= resolutions.path_for(pack).join(path)
    end

  end
end
