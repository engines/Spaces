module Adapters
  module CloudFormation
    class Orchestration < ::Adapters::Orchestration

      #TODO: fix this ... it's the same hack as in DockerCompose
      def artifact_qualifiers = []

    end
  end
end
