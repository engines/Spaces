module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < ::Artifacts::Aws::RouteTableStanza

        def name_snippet = nil
        def more_snippets = RouteTable::More.new(self).content

      end
    end
  end
end
