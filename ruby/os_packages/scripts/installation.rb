require_relative '../../collaborators/script_once'

module OsPackages
  module Scripts
    class Installation < Collaborators::ScriptOnce

      def body
        "apt-get -y #{context.all.map { |a| a.name }.compact.uniq.join(' ')}"
      end

    end
  end
end
