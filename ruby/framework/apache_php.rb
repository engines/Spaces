require_relative 'framework'

module Framework
  class ApachePHP < Framework
    class << self
      def identifier
        'apache_php'
      end
    end

    def initial
      'FROM spaces/php:current'
    end

    def variables
      %Q(
        ENV ContUser www-data
        ENV CONTFSVolHome /home/fs/
        ENV ContUser www-data
        ENV CONTFSVolHome /home/fs/

        ENV FRAMEWORK '#{identifier}'
        ENV RUNTIME '#{identifier}'
        ENV PORT '8000'
      )
    end

    def adds
      [
        super,
        %Q(
          ADD scripts /scripts
          ADD home home
          ADD spaces home/spaces
        )
      ]
    end

    def scripts
      %Q(
        RUN apt-get update -y
        USER 0
        RUN   /scripts/configure_apache.sh
        RUN \
          bash /home/setup.sh
        RUN \
          /scripts/set_data_permissions.sh&& \
          /scripts/_finalise_environment.sh
      )
    end

  end
end
