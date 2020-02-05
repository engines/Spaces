require_relative '../../spaces/script'

module Nodule
  class Nodules
    class OsPackages < Spaces::Script

      def body
        "apt-get -y #{context.all.map { |n| n.os_package }.compact.uniq.join(' ')}"
      end

      def file_name
        "#{identifier}.sh"
      end

      def identifier
        'os_packages'
      end

    end
  end
end
