require_relative '../../../../releases/stanza'

module Provisioning
  module Providers
    module Lxd
      module Stanzas
        class Provider < ::Releases::Stanza

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
end
