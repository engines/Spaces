module Providers
  class Lxd < ::Providers::Provider

    def provider_stanzas
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
          name     = "lxd-server"
          scheme   = "https"
          address  = "192.168.20.220"
          password = "#{configuration.password}"
          default  = true
        }
      )
    end

    def pool_stanzas
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
