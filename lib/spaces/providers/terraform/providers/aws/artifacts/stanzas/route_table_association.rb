module Artifacts
  module Terraform
    module Aws
      class RouteTableAssociationStanza < ::Artifacts::Aws::RouteTableAssociationStanza

        def name_snippet = nil
        def more_snippets = RouteTable::Association.new(self).content

      end
    end
  end
end
