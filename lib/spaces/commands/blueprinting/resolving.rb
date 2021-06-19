require_relative 'settling'

module Blueprinting
  module Commands
    class Resolving < Settling

      def resolution
        @resolution ||= model.resolution_in(arena)
      end

      protected

      def commit
        universe.resolutions.save(resolution)
      end

    end
  end
end
