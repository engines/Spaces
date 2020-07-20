require_relative '../stanza'

module Terraform
  module Stanzas
    class Modules < ::Terraform::Stanza

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
