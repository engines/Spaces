require_relative 'framework'

module Framework
  class ApachePHP < Framework
    class << self
      def identifier
        'apache_php'
      end
    end

    def first_layer(descriptor)
      "FROM spaces/php:#{descriptor.branch}"
    end

    def setup_layers
      %Q(
        ENV ContUser www-data
        ENV CONTFSVolHome /home/fs/

        ADD scripts /scripts
        ADD home home
        ADD spaces home/spaces

        RUN apt-get update -y
      )
    end

    def stack_layers
      %Q(
        ENV FRAMEWORK '#{identifier}'
        ENV RUNTIME '#{identifier}'
        ENV PORT '8000'
      )
    end

    def mid_layers
      %Q(
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
