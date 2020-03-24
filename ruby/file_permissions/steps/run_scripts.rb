require_relative '../../docker/files/step'

module FilePermissions
  module Steps
    class RunScripts < Docker::Files::Step

      def product
        'RUN file_permissions.sh'
      end

    end
  end
end
