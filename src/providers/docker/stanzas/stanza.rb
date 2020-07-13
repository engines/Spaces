require_relative '../../../terraform/stanza'

module Providers
  module Docker
    module Stanzas
      class Stanza < ::Terraform::Stanza

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
