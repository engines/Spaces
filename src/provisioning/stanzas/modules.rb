require_relative '../stanza'

module Provisioning
  module Stanzas
    class Modules < Stanza

      def declaratives
        context.resolutions.map do |r|
          %Q(
            module "#{r.identifier}" {
              source = "./modules/turtle"
              name  = "#{r.identifier}"
              image = "#{r.image_name}"
            }
          )
        end.join("\n")
      end

    end
  end
end
