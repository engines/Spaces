require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class ServiceNetworking < ::Releases::Stanza

      def declaratives
        context.service_networking_default.stanzas.map(&:declaratives).join("\n")
      end

    end
  end
end
