require_relative 'requires'

module Container
  module Docker
    class File
      class Final < Step

        def content
          %Q(
            RUN \
              /scripts/set_data_permissions.sh && \
              /scripts/_finalise_environment.sh && \
              /home/engines/scripts/build/post_build_clean.sh
            ENV buildtime_only '.'
            USER $ContUser
            CMD ['/home/engines/scripts/startup/start.sh']
          )
        end
      end

    end
  end
end
