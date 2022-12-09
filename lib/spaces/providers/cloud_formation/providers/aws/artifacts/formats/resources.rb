require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class Resources < Hcl

          delegate(substanzas: :holder)

          def content =
            substanzas.reduce({}) { |m,s| m.merge(s.content) }

        end
      end
    end
  end
end
