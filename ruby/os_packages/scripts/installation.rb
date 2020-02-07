require_relative '../../spaces/script'

module OsPackages
  class OsPackages < ::Spaces::Product
    class Installation < Spaces::Script

      def body
        "apt-get -y #{context.all.map { |a| a.name }.compact.uniq.join(' ')}"
      end

      def identifier
        'installation'
      end

    end
  end
end
