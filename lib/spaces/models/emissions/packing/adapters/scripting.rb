require_relative 'pack'
require_relative 'script_paths'

module Adapters
  class Scripting < Pack
    include Keyed
    include ScriptPaths

    alias_method :path, :script_path

  end
end
