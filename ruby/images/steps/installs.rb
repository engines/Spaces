require_relative '../../docker/files/step'

module Images
  module Steps
    class Installs <  Docker::Files::Step
      def product
        if context.project_scripts.map(&:file_name).include?('install.sh')
          %Q(
          WORKDIR /home/
         # RUN bash /home/engines/scripts/run/setup.sh
          RUN bash /home/run/scripts/engines/install.sh
          )
        end
      end
    end
  end
end
