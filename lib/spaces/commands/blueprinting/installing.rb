require_relative 'settling'

module Blueprinting
  module Commands
    class Installing < Settling

      def installation
        @installation ||= model.installation_in(arena)
      end

      protected

      def commit
        universe.installations.save(installation)
      end

    end
  end
end
