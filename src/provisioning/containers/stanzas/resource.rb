require_relative '../../../emitting/stanza'

module Provisioning
  module Containers
    module Stanzas
      class Resource < ::Emitting::Stanza

        def declaratives
          Array.new(emission.count) do |i|
            q(emission.identifier, context, i)
          end.join("\n")
        end

      end
    end
  end
end
