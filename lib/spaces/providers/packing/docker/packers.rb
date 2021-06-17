module Providers
  class Docker < ::ProviderAspects::Provider
    class Packers < ::ProviderAspects::Packers

      # delegate [:packing_artifacts, :auxiliary_folders, :source_path_for, :copy_source_path_for] => :division
      delegate [:packing_artifacts] => :division

      def packing_artifact; packing_artifacts.compact.join("\n") ;end

      def auxiliary_file_artifact_for(path)
        "ADD #{path.basename}/ /tmp/"
      end

      def file_copy_artifact_for(folder, precedence) ;end

    end
  end
end
