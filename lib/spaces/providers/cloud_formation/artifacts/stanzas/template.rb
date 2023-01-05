module Artifacts
  module CloudFormation
    module Stanzas
      class Template < ::Artifacts::Stanzas::Stanza

        def resolution = emission

        def stanza_qualifiers =
          # [:capsules, :resources]
          [:resources]

        def snippets
          stanza_qualifiers.reduce({}) do |m, q|
            m.tap do
              m[q] = stanza_class_for(q).new(self).snippets
            end
          end.compact
        end

      end
    end
  end
end
