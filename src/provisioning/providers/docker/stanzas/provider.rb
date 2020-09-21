require_relative '../../../../emitting/emissions/stanza'

module Provisioning
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
end
