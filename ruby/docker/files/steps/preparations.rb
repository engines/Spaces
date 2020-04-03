require_relative 'requires'

module Docker
  module Files
    module Steps
      class Preparations < Step

        def product
          %Q(
         USER 0
          RUN \
            /scripts/set_user_identifier.sh && \
            ln -s /usr/local/ /home/local && \
            chown -R $ContUser /usr/local/ && \
            add-apt-repository  -y ppa:opencpn/opencpn && \
            apt-get -y update && \
          )
        end

      end
    end
  end
end
