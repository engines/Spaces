module Providers
  class Docker < ::Providers::Provider

    def provider_stanzas
      %(
        provider "#{type}" {
        }
      )
    end

    def required_stanza
      %(
        docker = {
          source = "kreuzwerker/docker"
          version = "2.11.0"
        }
      )
    end

  end
end
