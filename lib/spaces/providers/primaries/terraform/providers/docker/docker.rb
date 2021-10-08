module Providers
  module Terraform
    module Docker
      class Docker < ::Adapters::Provider

        def provider_snippets
          %(
            provider "#{type}" {
              # Note need to expand this to support remote hosts
              host = "unix:///var/run/docker.sock"
            }
          )
        end

        def required_snippet
          %(
            docker = {
              version = "#{configuration.version}"
              source = "#{configuration.source}"
            }
          )
        end

      end
    end
  end
end
