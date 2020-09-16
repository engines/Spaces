require_relative '../../../../releases/stanza'

module Provisioning
  module Providers
    module Docker
      module Stanzas
        class Provider < ::Releases::Stanza

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
