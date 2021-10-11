module Providers
  module Terraform
    module Lxd
      class Lxd < ::Providers::Provider

        def provider_snippets
          [provider_snippet, pool_snippets].join
        end

        def provider_snippet
          %(
            provider "#{type}" {
              generate_client_certificates = "#{configuration.generate_client_certificates}"
              accept_remote_certificate    = "#{configuration.accept_remote_certificate}"

              #{remote_snippet}
            }
          )
        end

        def remote_snippet
          %(
            lxd_remote {
              name     = "lxd-server"
              scheme   = "#{arena.configuration.scheme}"
              address  = "#{arena.configuration.address}"
              password = "#{arena.configuration.password}"
              default  = true
              #{optional_port_declaration}
            }
          )
        end

        def optional_port_declaration
          %(port = "#{arena.configuration.port}") if arena.configuration.respond_to?(:port)
        end

        def pool_snippets
          %(
            resource "#{type}_storage_pool" "data-pool" {
              name = "data"
              driver = "btrfs"
              remote = "lxd-server"
            }

            resource "#{type}_storage_pool" "logs-pool" {
              name = "logs"
              driver = "btrfs"
            }
          )
        end

        def required_snippet
          %(
            lxd = {
              version = "#{configuration.version}"
              source = "#{configuration.source}"
            }
          )
        end

      end
    end
  end
end
