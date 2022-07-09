module Orchestrating
  module Commands
    class Saving < ::Spaces::Commands::Saving

      def model
        @model ||= resolution.orchestrated
      end

      def resolution = universe.resolutions.by(identifier)

    end
  end
end
