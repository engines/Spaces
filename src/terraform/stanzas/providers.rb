require_relative '../stanza'

module Terraform
  module Stanzas
    class Providers < ::Terraform::Stanza

      def declaratives
        %Q(
          # ------------------------------------------------------------
          # Let terraform know about LXD.
          # ------------------------------------------------------------
          provider "lxd" {
            # This works using the local unix domain socket. You MUST be in the lxd group.
            generate_client_certificates = true
            accept_remote_certificate    = true
          }
        )
      end

    end
  end
end
