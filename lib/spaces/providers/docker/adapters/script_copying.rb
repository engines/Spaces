module Adapters
  module Docker
    class ScriptCopying < ::Adapters::ScriptCopying

      def snippets_for(precedence)
        "ADD #{path}/ #{temporary_script_path}/" if has_scripts?
      end

    end
  end
end
