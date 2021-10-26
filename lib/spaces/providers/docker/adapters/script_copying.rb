module Adapters
  module Docker
    class ScriptCopying < ::Adapters::ScriptCopying

      def snippets_for(precedence)
        "ADD #{path}/ #{temporary_script_path}/"
      end

    end
  end
end
