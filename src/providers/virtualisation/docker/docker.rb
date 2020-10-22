module Providers
  class Docker < ::Divisions::Provider

    def arena_stanzas
      %Q(
        provider "#{type}" {
        }
      )
    end

  end
end
