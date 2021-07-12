module Providers
  class Docker < ::ProviderAspects::Provider

    def provider_stanzas
      %(
        provider "#{type}" {
        # Note need to expand this to support remore hosts                                      \                 
         host = "unix:///var/run/docker.sock"
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
