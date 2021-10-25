require_relative 'pack'
require_relative 'script_paths'

module Adapters
  class ScriptRunning < Pack
    include Keyed
    include ScriptPaths

    alias_method :path, :script_path

    def adapter_keys
      precedence & directories.map { |d| :"#{d.basename}" }
    end

    def directories
      @directories ||=
        if (p = resolutions.path_for(pack).join(path)).exist?
          p.children.select(&:directory?)
        end || []
    end

  end
end
