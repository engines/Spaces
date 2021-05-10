require_relative 'saving'

module Arenas
  module Commands
    class Configuring < Saving

      def model
        @model ||= super.merge(configuration)
      end

      def configuration
        @configuration ||= ::Spaces::Commands::Reading.new(identifier: input[:configuration_identifier], space: :configurations).run.result
      end

    end
  end
end
