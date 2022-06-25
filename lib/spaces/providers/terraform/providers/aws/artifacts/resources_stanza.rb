module Artifacts
  module Terraform
    module Aws
      class ResourcesStanza < ::Artifacts::Stanza

        def snippets
          stanzas.map(&:snippets).join("\n")
        end

        def stanzas
          @stanzas ||= emission.resources.map { |r| stanza_class_for(r.type).new(r) }
        end

      end
    end
  end
end
