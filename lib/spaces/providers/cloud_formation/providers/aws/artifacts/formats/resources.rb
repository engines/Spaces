require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Resources < Hash

          delegate(substanzas: :holder)

          def content =
            [formats.map(&:content)].flatten.
              reduce({}) { |m,c| m.merge(c) }

          def formats = substanzas.map(&:format)

        end
      end
    end
  end
end
