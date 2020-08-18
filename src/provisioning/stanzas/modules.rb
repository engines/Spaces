require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Modules < ::Releases::Stanza

      def declaratives
        context.resolutions.select(&:has_containers?).map do |r|
          r.containers.all.map do |c|
            Array.new(r.count) { |i| q(r.identifier, c, i) }
          end
        end.flatten.compact.join("\n")
      end

      def q(identifier, container, iteration)
        %Q(
          module "#{identifier}_#{container.type}_#{iteration}" {
            source  = "./modules/#{container.type}"
            name    = "#{identifier}_#{iteration}"
            image   = "#{container.image}"
            zone    = local.domain
          }
        )
      end

    end
  end
end
