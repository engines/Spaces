module Providers
  class Lxd < ::Divisions::Provider

    def arena_stanzas
      [provider_stanza, pool_stanzas].join("\n")
    end

    def provider_stanza
      %Q(
        provider "#{type}" {
          # This works using the local unix domain socket. You MUST be in the lxd group.
          generate_client_certificates = true
          accept_remote_certificate    = true
        }
      )
    end

    def pool_stanzas
      %Q(
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
