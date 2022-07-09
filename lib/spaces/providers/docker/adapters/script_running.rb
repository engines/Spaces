module Adapters
  module Docker
    class ScriptRunning < ::Adapters::ScriptRunning

      def snippets_for(precedence) =
        "RUN #{temporary_script_paths_for(precedence).join(connector)}"

      def connector = " &\&\\\n  "

    end
  end
end
