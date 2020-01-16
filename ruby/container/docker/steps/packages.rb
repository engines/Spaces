require_relative 'requires'
require_relative '../../package'

module Container
  module Docker
    class Packages < Step

      def content
        [
          %Q(
            apt-get install -y mysql-client make && \
          ), # TODO: how do we generalise this? with a dependency!

          package_class.new(context.tensor.descriptor).installation
        ]
      end

      def package_class
        Package
      end

    end
  end
end
