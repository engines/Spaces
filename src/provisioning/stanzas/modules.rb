require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Modules < ::Releases::Stanza

      def declaratives
        context.resolutions.map do |r|
          %Q(
            module "#{r.identifier}" {
              source = "./modules/turtle"
              name  = "#{r.identifier}"
            }
          )
        end.flatten.join("\n")
      end

    end
  end
end
