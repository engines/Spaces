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
          powerdns = {
          version = ">= 0"
          source = "pan-net/docker"
          }
       )
 end
  end
end
