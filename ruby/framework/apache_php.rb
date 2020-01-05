require_relative 'framework'

module Framework
  class ApachePHP < Framework
    class << self
      def identifier
        'apache_php'
      end
    end

    def first_layer(descriptor)
      "FROM engines/php:#{descriptor.branch}"
    end

    def setup_layers
      %Q(
        ENV ContUser www-data
        ENV CONTFSVolHome /home/fs/

        ADD build_scripts /build_scripts
        ADD home home
        ADD engines home/engines

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
        RUN   /build_scripts/configure_apache.sh
        RUN \
          bash /home/setup.sh
        RUN \
          /build_scripts/set_data_permissions.sh&& \
          /build_scripts/_finalise_environment.sh
      )
    end

    def startup_layer
      "ADD home/start.sh #{start_script_path}"
    end

    def start_layers
      %Q(
        USER $ContUser
        CMD ["#{start_script_path}"]
      )
    end

    def start_script_path
      '/home/engines/scripts/startup/start.sh'
    end

  end
end
