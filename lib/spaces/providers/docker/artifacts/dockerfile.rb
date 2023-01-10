module Artifacts
  module Docker
    class Dockerfile < ::Artifacts::Artifact

      def filename = qualifier.camelize

    end
  end
end
