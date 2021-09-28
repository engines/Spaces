module Providers
  module Docker
    class Scripts < ::ProviderAspects::Scripts

      delegate [:scripts_for, :temporary_script_path] => :division

      def packing_artifact_for(precedence)
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
