module Artifacts
  module CloudFormation
    module Aws
      class ResourcesStanza < Stanza

        def snippets =
          stanzas.reduce({}) { |m,s| m.merge(s.snippets) }

        def stanzas
          @stanzas ||= emission.resources.map { |r| stanza_class_for(r.type).new(r) }
        end

      end
    end
  end
end
