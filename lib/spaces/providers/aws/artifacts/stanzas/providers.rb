module Artifacts
  module Aws
    class ProvidersStanza < ::Artifacts::Stanza

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::Providers.new(self)
      end

    end
  end
end
