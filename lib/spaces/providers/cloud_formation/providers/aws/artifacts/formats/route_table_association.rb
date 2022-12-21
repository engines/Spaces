require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class RouteTableAssociation < Hash

          def name_snippet = nil
          def tags_snippet = nil

          def more_snippets =
            {
              subnet_id: {
                ref: qualification_for(:subnet_binding, :subnet)
              },
              route_table_id: {
                ref: qualification_for(:route_table_binding, :route_table)
              }
            }

        end
      end
    end
  end
end
