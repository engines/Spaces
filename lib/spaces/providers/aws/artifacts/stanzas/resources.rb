module Artifacts
  module Aws
    class ResourcesStanza < ::Artifacts::Stanza

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::Resources.new(self)
      end

    end
  end
end
