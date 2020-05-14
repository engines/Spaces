require_relative '../step'

module Docker
  module Files
    module Steps
      class Final < Step

        def instructions
          %Q(
          RUN /build/scripts/set_data_permissions.sh && \
            apt-get -y clean;\
            apt-get -y autoremove;\
            apt-get -y autoclean;\
            rm -r /tmp/*

          USER $ContUser
          CMD ['/home/engines/scripts/startup/start.sh']
          )
        end

      end
    end
  end
end
