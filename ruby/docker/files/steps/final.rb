require_relative 'requires'

module Docker
  module Files
    module Steps
      class Final < Step

        def product
          %Q(
          RUN /build/scripts/set_data_permissions.sh && \
              /build/scripts/framework/#{context.installation.framework.identifier}/finalisation.sh && \
              apt-get -y clean;\
              apt-get  -y autoremove;\
              apt-get  -y autoclean;\
              rm -r /tmp/* 

          USER $ContUser
          CMD ['/home/engines/scripts/startup/start.sh']
          )
        end

      end
    end
  end
end
