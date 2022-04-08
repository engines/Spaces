module Artifacts
  module Terraform
    module PowerDns
      class ProviderStanza < ::Artifacts::Stanza

        def snippets
          %(
            provider "powerdns" {
              api_key    = "#{api_key}"
              server_url = "#{protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
          )
        end

        def api_key; configuration.api_key ;end
        def protocol; configuration.protocol || 'http' ;end
        def port; configuration.port || 8081 ;end
        def endpoint; configuration.endpoint ;end

        def configuration
          # TODO: refactor this long method chain
          arena.role_providers.dns.resolution.configuration
        end

      end
    end
  end
end
