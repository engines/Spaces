module Providers
  class Lxd < ::Providers::Provider

    def arena_stanzas
      [provider_stanza, pool_stanzas].join
    end

    def provider_stanza
      %(
        provider "#{type}" {
          generate_client_certificates = "#{configuration.generate_client_certificates}"
          accept_remote_certificate    = "#{configuration.accept_remote_certificate}"

          #{remote_stanza}
        }
      )
    end

    def remote_stanza
      %(
        lxd_remote {
          name     = "local-lxd-server"
          scheme   = "https"
          address  = "127.0.0.1"
          password = "#{configuration.password}"
          default  = true
        }
      )
    end

    def pool_stanzas
      %(
        resource "#{type}_storage_pool" "data-pool" {
          name = "data-pool"
          driver = "dir"
          config = {
            source = "/var/lib/containers/#{arena.identifier}/data"
          }
        }

        resource "#{type}_storage_pool" "logs-pool" {
          name = "logs-pool"
          driver = "dir"
          config = {
            source = "/var/lib/containers/#{arena.identifier}/logs"
          }
        }
      )
    end

    def required_stanza
      %(
        lxd = {
          version = "#{configuration.version}"
          source = "#{configuration.source}"
        }
      )
    end

  end
end
