require_relative '../../docker/files/step'

module Images
  module Steps
    class Finish < Docker::Files::Step
      def instructions
        %Q(
          RUN #{context.release_path}/set_data_permissions.sh && \
            apt-get -y clean &&\
            apt-get -y autoremove &&\
            apt-get -y autoclean &&\
            rm -r /tmp/*

          USER $ContUser
          CMD ['/home/engines/scripts/startup/start.sh']
          )
      end

    end
  end
end

