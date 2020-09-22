require_relative '../../../emitting/emissions/stanza'

module Providers
  module LXD
    module Stanzas
      class Provider < ::Emissions::Stanza

        def declaratives
          %Q(
            provider "#{identifier}" {
              # This works using the local unix domain socket. You MUST be in the lxd group.
              generate_client_certificates = true
              accept_remote_certificate    = true
            }
          )
        end

      end
    end
  end
end
