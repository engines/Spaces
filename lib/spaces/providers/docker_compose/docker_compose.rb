module Providers
  module DockerCompose
    class DockerCompose < ::Providers::Provider

      def compute_qualifier = struct[:compute_qualifier] || :docker_compose
        
    end
  end
end
