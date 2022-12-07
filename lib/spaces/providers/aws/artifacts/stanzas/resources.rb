module Artifacts
  module Aws
    module Stanzas
      class Resources < Stanza

        delegate(resources: :emission)

        def substanzas
          @substanzas ||= resources.map { |r| stanza_class_for(r.type).new(self, r) }
        end

      end
    end
  end
end
