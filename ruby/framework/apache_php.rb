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

  end
end
