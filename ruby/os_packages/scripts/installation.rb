require_relative '../../products/script'

module OsPackages
  module Scripts
    class Installation < Products::Script

      def body
        "apt-get -y #{context.all.map { |a| a.name }.compact.uniq.join(' ')}"
      end

      def identifier
        'installation'
      end

    end
  end
end
