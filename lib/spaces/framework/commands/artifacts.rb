require_relative 'reading'

module Spaces
  module Commands
    class Artifacts < Reading

      protected

      def assembly = space.artifacts_for(identifier).map(&:content)

    end
  end
end
