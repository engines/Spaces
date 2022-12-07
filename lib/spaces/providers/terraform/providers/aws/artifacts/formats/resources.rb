require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class Resources < Hcl

          delegate(substanzas: :holder)

          def content = substanzas.map(&:content).join("\n")

        end
      end
    end
  end
end
