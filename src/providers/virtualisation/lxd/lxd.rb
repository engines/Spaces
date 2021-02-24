module Providers
  class Lxd < ::Divisions::Provider
    def arena_stanzas
      [provider_stanza, pool_stanzas].join("\n")
    end

    def provider_stanza
      %(
        provider "#{type}" {
          generate_client_certificates = "#{configuration.generate_client_certificates}"
          accept_remote_certificate    = "#{configuration.accept_remote_certificate}"
        }
      )
    end

    def required_stanza;
      %(
        lxd = {
          version = "#{configuration.version}"
          source = "#{configuration.source}"
        }
      )
    end

    def pool_stanzas
      %(
        resource "#{type}_storage_pool" "data-pool" {
          name = "data"
          driver = "dir"
          config = {
            source = "/var/lib/containers/#{emission.identifier}/data"
          }
        }

        resource "#{type}_storage_pool" "logs-pool" {
          name = "logs"
          driver = "dir"
          config = {
            source = "/var/lib/containers/#{emission.identifier}/logs"
          }
        }
      )
    end
  end
end
