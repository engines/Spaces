require_relative '../../docker/files/step'

module OsPackage
  class OsPackages < ::Spaces::Product
    class RunScripts < Docker::File::Step

      def content
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
