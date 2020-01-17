require_relative 'requires'

module Framework
  class Rails5
    class RakeTasks < Container::Docker::Step

      def content
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
