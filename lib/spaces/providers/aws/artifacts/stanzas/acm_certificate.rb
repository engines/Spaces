require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class AcmCertificate < Resource

        def more_snippets_keys =
          [:domain_name, :validation_method, :create_before_destroy]

      end
    end
  end
end
