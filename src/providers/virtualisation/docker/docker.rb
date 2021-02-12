module Providers
  class Docker < ::Divisions::Provider
    def arena_stanzas
      %(
        provider "#{type}" {
        }
      )
    end

    def providers_require
      %(
        docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
        }
       )
 end
  end
end
