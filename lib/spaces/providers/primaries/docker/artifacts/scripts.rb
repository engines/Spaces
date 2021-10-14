module Artifacts
  module Docker
    class Scripts < ::Artifacts::Scripts

      delegate [:scripts_for, :temporary_script_path] => :division

      def snippets_for(precedence)
        "RUN #{temporary_script_paths_for(precedence).join(connector)}"
      end

      def temporary_script_paths_for(precedence)
        scripts_for(precedence).map do |s|
          temporary_script_path.join("#{precedence}", s)
        end
      end

      def connector; " &\&\\\n  " ;end

    end
  end
end
