require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class Resources < Hcl

          def content = stanzas.map(&:content).join("\n")

          def stanzas
            @stanzas ||= emission.resources.map { |r| stanza_class_for(r.type).new(r) }
          end

        end
      end
    end
  end
end
