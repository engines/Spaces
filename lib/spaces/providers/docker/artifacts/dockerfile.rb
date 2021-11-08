module Artifacts
  module Docker
    class Dockerfile < ::Artifacts::Packing::Artifact

      def filename; qualifier.camelize ;end

    end
  end
end
