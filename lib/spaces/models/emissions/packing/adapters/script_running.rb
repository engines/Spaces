require_relative 'scripting'

module Adapters
  class ScriptRunning < Scripting

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
