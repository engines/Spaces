require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Containers < ::Releases::Stanza

      def declaratives
        context.resolutions.select(&:has_containers?).map do |r|
          r.containers.all.map { |c| c.stanzas.map(&:declaratives) }
        end.flatten.compact.join("\n")
      end

    end
  end
end
