require_relative '../../../docker/files/step'

module Frameworks
  module Rails5
    module Steps
      class RakeTasks < Docker::Files::Step

        def instructions
          %Q(
          USER 0
          RUN /scripts/configure_nginx.sh &&\
          	/scripts/create_database_yml.sh

          USER $ContUser
          RUN bash /home/setup.sh &&\
            /scripts/run_bundler.sh

          RUN \
            /scripts/run_rake_task.sh db:migrate&& \
            /scripts/run_rake_task.sh db:seed&& \
            /scripts/run_rake_task.sh assets:precompile
          )
        end

      end
    end
  end
end
