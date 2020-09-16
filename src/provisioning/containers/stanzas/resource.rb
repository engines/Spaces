require_relative '../../../releases/stanza'

module Provisioning
  module Containers
    module Stanzas
      class Resource < ::Releases::Stanza

        def declaratives
          Array.new(collaboration.count) do |i|
            q(collaboration.identifier, context, i)
          end.join("\n")
        end

      end
    end
  end
end
