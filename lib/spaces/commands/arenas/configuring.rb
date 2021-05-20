require_relative 'saving'

module Arenas
  module Commands
    class Configuring < Saving

      def model
        @model ||= super.merge(configuration)
      end

      def configuration
        @configuration ||= universe.configurations.by(input[:configuration_identifier])
      end

    end
  end
end
