module Providers
  class Docker < ::Divisions::Provider

    def arena_stanzas
      %Q(
        provider "#{identifier}" {
        }
      )
    end
    
  end
end
