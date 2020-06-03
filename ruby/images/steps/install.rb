require_relative '../../docker/files/step'

module Images
  module Steps
    class Install <  Docker::Files::Step
      def instructions
        if context.blueprint_scripts.map(&:file_name).include?('install.sh')
          %Q(
          WORKDIR /home/
          RUN bash /home/engines/scripts/run/install.sh
          )
        end
      end
    end
  end
end
