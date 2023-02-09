require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class ClusterKey < Hash

          def configuration_hash
            super.tap { |c| c[:enabled] = c.delete(:is_enabled) }
          end

          def name_snippet = nil

        end
      end
    end
  end
end
