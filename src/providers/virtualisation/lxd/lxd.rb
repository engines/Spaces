module Providers
  class Lxd < ::Divisions::Provider

    def arena_stanzas
      %Q(
        provider "#{type}" {
          # This works using the local unix domain socket. You MUST be in the lxd group.
          generate_client_certificates = true
          accept_remote_certificate    = true
        }
      )
    end

  end
end
