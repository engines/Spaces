module Providers
  module Docker
    module Stanzas
      class Provider < ::Emissions::Stanza

        def declaratives
          %Q(
            provider "#{identifier}" {
            }
          )
        end

      end
    end
  end
end
