require_relative '../stanza'

module Terraform
  module Stanzas
    class Modules < ::Terraform::Stanza

      def declaratives
        context.resolutions.map do |r|
          %Q(
            # ------------------------------------------------------------
            # #{r.identifier} container
            # ------------------------------------------------------------

            module "#{r.identifier}" {
              source = "./modules/turtle-container"
              name  = "#{r.identifier}"
              image = "engines/beowulf/base/20200623/1143"
            }
          )
        end.join("\n")
      end

    end
  end
end
