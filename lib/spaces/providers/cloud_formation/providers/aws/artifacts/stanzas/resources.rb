module Artifacts
  module CloudFormation
    module Aws
      class ResourcesStanza < Stanza

        def snippets = stanzas.map(&:snippets).join("\n")

        def stanzas
          @stanzas ||= emission.resources.map { |r| stanza_class_for(r.type).new(r) }
        end

      end
    end
  end
end
