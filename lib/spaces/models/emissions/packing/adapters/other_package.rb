require_relative 'script_paths'

module Adapters
  class OtherPackage < Division
    include ScriptPaths

    def environment_vars
      [:repository, :extraction, :extracted_path, :destination].map do |v|
        division.send(v) if division.respond_to?(v)
      end
    end

  end
end
