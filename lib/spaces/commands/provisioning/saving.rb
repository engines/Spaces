module Provisioning
  module Commands
    class Saving < ::Spaces::Commands::Saving

      def model
        @model ||= resolution.provisioned
      end

      def resolution
        universe.resolutions.by(identifier)
      end

      def space_name
        super || :provisioning
      end

    end
  end
end
