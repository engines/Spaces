module Artifacts
  module Terraform
    module Aws
      module Snippets
        class Name < Snippet

          def content = %(name = "#{resource_identifier}")

          # def content = {name: resource_identifier}

        end
      end
    end
  end
end
