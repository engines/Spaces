require_relative '../../texts/one_time_script'

module OsPackages
  module Scripts
    class Installation < Texts::OneTimeScript

      def body
        "apt-get install -y #{context.all.map(&:name).compact.uniq.join(' ')}"
      end

    end
  end
end
