require_relative '../../../../releases/stanza'

module Provisioning
  module Providers
    module Docker
      module Stanzas
        class Provider < ::Releases::Stanza

          def declaratives
            %Q(
              provider "#{identifier}" {
                host = "tcp://127.0.0.1:2376/"
              }
            )
          end

        end
      end
    end
  end
end
