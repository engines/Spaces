require_relative '../../docker/files/step'

module OsPackages
  class OsPackages < ::Spaces::Product
    class RunScripts < Docker::Files::Step

      def content
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
