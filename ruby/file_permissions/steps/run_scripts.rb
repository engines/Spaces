require_relative '../../docker/files/step'

module FilePermissions
  module Steps
    class RunScripts < Docker::Files::Step

      def product
        context.scripts.flatten.map { |s| "RUN #{s.path}" }
      end

    end
  end
end
