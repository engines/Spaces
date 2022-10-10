module Artifacts
  module Terraform
    module Aws
      module Named

        def name_snippet = %(name = "#{resource_identifier}")

      end
    end
  end
end
