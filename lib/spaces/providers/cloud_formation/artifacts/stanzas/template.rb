module Artifacts
  module CloudFormation
    module Stanzas
      class Template < ::Artifacts::Stanzas::Stanza

        def stanza_qualifiers =
          [:services, :resources]

        def snippets = { Resources: resources }

        def resources =
          stanzas.inject({}) do |m, s|
            m.merge(s.snippets)
          end.compact

        def stanzas =
          stanza_qualifiers.map { |q| stanza_class_for(q).new(self) }

      end
    end
  end
end
