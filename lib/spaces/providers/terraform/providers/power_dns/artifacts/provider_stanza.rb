module Providers
  module Terraform
    module PowerDns
      class PowerDns < ::Artifacts::Stanza

        def provider_snippets
          %(
            provider "powerdns" {
              api_key    = "#{configuration.api_key}"
              server_url = "#{protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
            resource "powerdns_zone" "#{arena.identifier}-zone" {
              name        = "#{arena.identifier}.#{universe.host}."
              kind        = "native"
              nameservers = [#{dns_address}]
            }
          )
        end

        def required_snippet
          %(
            powerdns = {
              version = "#{configuration.version}"
              source  = "#{configuration.source}"
            }
          )
        end

      end
    end
  end
end
