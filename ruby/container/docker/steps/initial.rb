require_relative 'requires'

module Container
  module Docker
    class Initial < Step

      def content
        %Q(
          "COPY sudo_list /etc/sudoers.d/container"
          USER 0
          RUN \
            /scripts/set_cont_user.sh && \
            ln -s /usr/local/ /home/local && \
            chown -R $ContUser /usr/local/ && \
            add-apt-repository  -y ppa:opencpn/opencpn && \
            apt-get -y update && \
        )
      end

    end
  end
end
