require_relative '../../../stanza'

module Terraform
  module Providers
    module Docker
      module Stanzas
        class Provider < Stanza

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
