require_relative 'scripting'

module Adapters
  class ScriptRunning < Scripting

    def adapter_keys
      precedence & directories.map { |d| :"#{d.basename}" }
    end

    def directories
      @directories ||=
        has_scripts? ? absolute_path.children.select(&:directory?) : []
    end

  end
end
