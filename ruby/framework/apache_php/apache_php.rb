require_relative '../framework'

module Framework
  class ApachePHP < Framework
    class << self
      def identifier
        'apache_php'
      end

      def step_precedence
        @@apache_php_step_precedence ||= {}
      end
    end

    def initial
      'FROM spaces/php:current'
    end

    def variables
      [
        super,
        %Q(
          ENV ContUser www-data
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
