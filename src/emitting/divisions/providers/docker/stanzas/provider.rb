require_relative '../../../../emissions/stanza'

module Providers
  module Docker
    module Stanzas
      class Provider < ::Emitting::Stanza

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
