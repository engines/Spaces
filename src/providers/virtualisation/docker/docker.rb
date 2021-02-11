module Providers
  class Docker < ::Divisions::Provider
    def arena_stanzas
      %(
        provider "#{type}" {
        }
      )
    end

    def providers_required; end
  end
end
