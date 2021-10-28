module Artifacts
  module Terraform
    module PowerDns
      class ProviderStanza < ::Artifacts::Stanza

        delegate(configuration: :dns)

        def snippets
          %(
            provider "powerdns" {
              api_key    = "#{api_key}"
              server_url = "#{protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
          )
        end

        def api_key; configuration.api_key ;end
        def protocol; configuration.struct.protocol || 'http' ;end
        def port; configuration.struct.port || 8081 ;end
        def endpoint; configuration.struct.endpoint ;end

      end
    end
  end
end
