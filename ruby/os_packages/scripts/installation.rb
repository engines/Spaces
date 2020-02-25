require_relative '../../texts/script_once'

module OsPackages
  module Scripts
    class Installation < Texts::ScriptOnce

      def body
        "apt-get -y #{context.all.map(&:name).compact.uniq.join(' ')}"
      end

    end
  end
end
