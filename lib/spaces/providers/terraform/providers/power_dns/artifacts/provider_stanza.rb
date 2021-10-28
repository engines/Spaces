module Artifacts
  module Terraform
    module PowerDns
      class ProviderStanza < ::Artifacts::Stanza

        def snippets
          %(
            provider "powerdns" {
              api_key    = "#{dns.api_key}"
              server_url = "#{dns.protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
          )
        end

        def dns; provider.dns_provider ;end

      end
    end
  end
end
