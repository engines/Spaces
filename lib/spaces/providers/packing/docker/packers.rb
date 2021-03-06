module Providers
  class Docker < ::ProviderAspects::Provider
    class Packers < ::ProviderAspects::Packers

      delegate script_path: :division

      def packing_artifact; packing_artifacts.compact.join("\n") ;end

      def auxiliary_file_artifact_for(path)
        "ADD #{script_path}/ #{temporary_script_path}/" if path.basename.to_s == 'packing'
      end

      def file_copy_artifact_for(folder, precedence)
        "ADD #{folder}/#{precedence}/ /"
      end

    end
  end
end
