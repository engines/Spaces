module Artifacts
  module Aws
    module Stanzas
      class Services < Stanza

        def snippets =
          substanzas.inject({}) { |m, s| m.merge(s.format.content)}

        def substanzas =
          service_resolutions.map do |r|
            stanza_class_for(:service).new(holder, r.compute_service)
          end

        def service_resolutions =
          directly_bound_resolutions.reject { |r| r.resourcer? }

      end
    end
  end
end
