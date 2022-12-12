require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Resources < Hash

          delegate(substanzas: :holder)

          def content =
            substanzas.reduce({}) { |m,s| m.merge(s.format.content) }

        end
      end
    end
  end
end
