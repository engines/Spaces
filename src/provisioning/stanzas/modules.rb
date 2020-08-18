require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Modules < ::Releases::Stanza

      def declaratives
        context.resolutions.select(&:has_containers?).map do |r|
          r.containers.all.map do |c|
            %Q(
              module "#{r.identifier}_#{c.type}" {
                source  = "./modules/#{c.type}"
                name    = "#{r.identifier}"
                image   = "#{c.image}"
                zone    = local.domain
              }
            )
          end
        end.flatten.compact.join("\n")
      end

    end
  end
end
