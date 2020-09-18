require_relative '../../../releases/stanza'

module Provisioning
  module Containers
    module Stanzas
      class Resource < ::Releases::Stanza

        def declaratives
          Array.new(release.count) do |i|
            q(release.identifier, context, i)
          end.join("\n")
        end

      end
    end
  end
end
