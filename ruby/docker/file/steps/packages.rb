require_relative 'requires'
require_relative '../../../software/package'

module Docker
  class File < ::Spaces::Product
    class Packages < Step

      def content
        "ADD /home/app /home"



        # [
        #   %Q(
        #     apt-get install -y mysql-client make && \
        #   ), # TODO: how do we generalise this?
        #
        #   package_class.new(context.tensor.descriptor).installation
        # ]
      end

      def package_class
        Package
      end

    end
  end
end
