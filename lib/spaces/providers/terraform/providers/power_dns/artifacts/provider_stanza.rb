module Artifacts
  module Terraform
    module PowerDns
      class ProviderStanza < ::Artifacts::Stanza

        def snippets =
          %(
            provider "powerdns" {
              api_key    = "#{api_key}"
              server_url = "#{protocol}://${#{dns_address}}:#{port}/#{endpoint}"
            }
          )

        def api_key = configuration.api_key
        def protocol = configuration.protocol || 'http'
        def port = configuration.port || 8081
        def endpoint = configuration.endpoint

        def configuration =
          arena.role_providers.dns.resolution.configuration
          # TODO: refactor this long method chain

      end
    end
  end
end
